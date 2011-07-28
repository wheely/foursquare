# encoding: utf-8
require 'spec_helper'

describe Foursquare::Client do
  before(:each) do
    @client = Foursquare.new(ENV['FOURSQUARE_ID'],ENV['FOURSQUARE_SECRET'])
  end
  
  it "should perform a search request" do
    result = nil
    EM.run {
      @client.callback do |locations|
        result = locations
        EM.stop
      end
      @client.search('48.218538,16.359950')
    }
    result.class.should == Array
  end
  
end