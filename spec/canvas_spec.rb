require File.expand_path('../spec_helper', __FILE__)

describe Canvas do
  after do
    Canvas.reset
  end

  # context "when delegating to a client" do

  #    before do
  #      stub_get("users/self/feed.json").
  #        to_return(:body => fixture("user_media_feed.json"), :headers => {:content_type => "application/json; charset=utf-8"})
  #    end

  # end

  describe ".client" do
    it "should be a Canvas::Client" do
      Canvas.client.should be_a Canvas::Client
    end
  end

  describe ".adapter" do
    it "should return the default adapter" do
      Canvas.adapter.should == Canvas::Configuration::DEFAULT_ADAPTER
    end
  end

  describe ".adapter=" do
    it "should set the adapter" do
      Canvas.adapter = :typhoeus
      Canvas.adapter.should == :typhoeus
    end
  end

  describe ".endpoint" do
    it "should return the default endpoint" do
      Canvas.endpoint.should == Canvas::Configuration::DEFAULT_ENDPOINT
    end
  end

  describe ".endpoint=" do
    it "should set the endpoint" do
      Canvas.endpoint = 'http://tumblr.com'
      Canvas.endpoint.should == 'http://tumblr.com'
    end
  end

  describe ".format" do
    it "should return the default format" do
      Canvas.format.should == Canvas::Configuration::DEFAULT_FORMAT
    end
  end

  describe ".format=" do
    it "should set the format" do
      Canvas.format = 'xml'
      Canvas.format.should == 'xml'
    end
  end

  describe ".user_agent" do
    it "should return the default user agent" do
      Canvas.user_agent.should == Canvas::Configuration::DEFAULT_USER_AGENT
    end
  end

  describe ".user_agent=" do
    it "should set the user_agent" do
      Canvas.user_agent = 'Custom User Agent'
      Canvas.user_agent.should == 'Custom User Agent'
    end
  end

  describe ".configure" do

    Canvas::Configuration::VALID_OPTIONS_KEYS.each do |key|

      it "should set the #{key}" do
        Canvas.configure do |config|
          config.send("#{key}=", key)
          Canvas.send(key).should == key
        end
      end
    end
  end

end