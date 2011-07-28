require 'em-http-request'
require 'em-synchrony/em-http'
require 'yajl/json_gem'

module Foursquare
  def self.new(client_id,client_secret,options={})
    Foursquare::Client.new(client_id,client_secret,options)
  end
end

require 'foursquare/client'
require 'foursquare/venue'