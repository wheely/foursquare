module Foursquare
  class Client
    include EventMachine::Deferrable
    
    # Create a new Foursquare client
    #
    # @param [String] client_id Your Application ID
    # @param [String] client_secret Your Application Secret
    # @param [Hash] options Options
    # @option options [String] :key Your BingMaps API key
    def initialize(client_id, client_secret, options={})
      @base_uri = 'https://api.foursquare.com'
      @defaults = {:client_id => client_id, :client_secret => client_secret, :v => '20110727'}
      self
    end
    
    # Get an address for a specified point (latitude and longitude)
    # @param [String] ll Latitude and longitude
    # @param [Hash] options Options
    # @option options [String] :query The query to use for the request
    def search(ll, options={})
      request("/v2/venues/search", :query => @defaults.merge(:ll => ll))
    end
    
    def request(url, opts)
      http = http_request(url, opts)
      http.errback { fail(Exception.new("An error occured in the HTTP request: #{http.errors}")) }
      http.callback do
        begin
          parsed = Yajl::Parser.parse(http.response)
          venues = parsed['response']['venues']
          venues = venues.map{|data| Foursquare::Venue.new(data)}
          succeed venues
        rescue Exception => e
          fail(e)
        end
      end
      http
    end

    def http_request(url, opts)
      EventMachine::HttpRequest.new(@base_uri + url).aget(opts)
    end
  end
end