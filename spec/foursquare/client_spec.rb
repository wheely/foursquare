# encoding: utf-8
require 'spec_helper'

describe Foursquare::Client do
  before(:each) do
    @client = Foursquare.new(ENV['FOURSQUARE_ID'],ENV['FOURSQUARE_SECRET'])
  end
  
  it "performs a search request" do
    result = nil
    EM.run do
      @client.callback do |locations|
        result = locations
        EM.stop
      end
      @client.search('48.218538,16.359950')
    end
    result.size.should > 0
  end

  it "accepts additional options" do
    result = nil
    EM.run do
      @client.callback do |locations|
        result = locations
        EM.stop
      end
      @client.search('38.89761038124561,-77.03672021627426', :query => 'White House')
    end

    result.size.should > 0
  end
end