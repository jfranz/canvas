require File.expand_path('../../spec_helper', __FILE__)

describe Canvas::Client do

  before do
    @client = Canvas::Client.new(:access_token => 'AT')
  end

  describe ".enroll_in_course" do

    before do
      # stub_post("courses/55/enrollments.json").
      stub_request(:post, 'https://canvas.instructure.com/api/v1/courses/55/enrollments.json').
        # with(:headers => {'Accept'=>'*/*', 'Authorization'=>'Bearer AT', 'Content-Length'=>'0', 'Content-Type'=>'application/json; charset=utf-8', 'User-Agent'=>'Canvas Ruby Gem 0.0.1'}).
        with(:body => {'enrollment' => { 'user_id' => 1324 }}).
        to_return(:status => 200, :body => fixture("account_response.json"))
    end
    it "generates a hash of supplied options" do
      @client.enroll_in_course(55, 1324)
      a_request(:post, "https://canvas.instructure.com/api/v1/courses/55/enrollments.json").
        # with(:headers => {'Accept'=>'*/*', 'Authorization'=>'Bearer AT', 'Content-Length'=>'0', 'Content-Type'=>'application/json; charset=utf-8', 'User-Agent'=>'Canvas Ruby Gem 0.0.1'}).
        with(:body => {'enrollment' => { 'user_id' => 1324 }}).
        should have_been_made
    end

    it "returns the profile of the couse / user" do
      resp = @client.enroll_in_course(55, 1324)
      resp.user_id.should == 1324
    end

    context "when sis options are set to true" do
      it "converts the user_id param into a hex" do
        @client.enroll_in_course('100-01CP2012Q2', 1324, sis_course: true, sis_user: true)
        a_request(:post, "https://canvas.instructure.com/api/v1/courses/55/enrollments.json").
          # with(:headers => {'Accept'=>'*/*', 'Authorization'=>'Bearer AT', 'Content-Length'=>'0', 'Content-Type'=>'application/json; charset=utf-8', 'User-Agent'=>'Canvas Ruby Gem 0.0.1'}).
          with(:body => {'enrollment' => { 'user_id' => "hex:sis_user_id:1234" }}).
          should have_been_made
      end
    end

  end

end