require File.expand_path('../../spec_helper', __FILE__)

describe Faraday::Response do
  before do
    @client = Canvas::Client.new
  end

  {
    400 => Canvas::BadRequest,
    404 => Canvas::NotFound,
    500 => Canvas::InternalServerError,
    503 => Canvas::ServiceUnavailable
  }.each do |status, exception|
    context "when HTTP status is #{status}" do

      before do
        stub_get('users/self/feed.json').
          to_return(:status => status)
      end

      xit "should raise #{exception.name} error" do
        lambda do
          @client.user_media_feed()
        end.should raise_error(exception)
      end

    end
  end

  context "when a 400 is raised" do
    before do
      stub_get('users/self/feed.json').
        to_return(:body => '{"meta":{"error_message": "Bad words are bad."}}', :status => 400)
    end

    xit "should return the body error message" do
      expect do
        @client.user_media_feed()
      end.should raise_error(Canvas::BadRequest, /Bad words are bad./)
    end
  end
end