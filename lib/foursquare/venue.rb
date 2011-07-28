module Foursquare
  class Venue
    attr_reader :id, :name, :verified, :contact, :location, :categories, :specials, :here_now
    
    def initialize(options={})
      @id = options['id']
      @name = options['name']
      @verified = options['verified']
      @contact = options['contact']
      @location = options['location']
      @categories = options['categories']
      @specials = options['specials']
      @here_now = options['hereNow']
    end
    
  end
end