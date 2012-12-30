require File.expand_path('../../lib/canvas', __FILE__)

require 'rspec'
require 'webmock/rspec'
# require 'faraday'
# require 'faraday_middleware'
RSpec.configure do |config|
  config.include WebMock::API
end

def a_delete(path)
  a_request(:delete, Canvas.endpoint + path)
end

def a_get(path)
  a_request(:get, Canvas.endpoint + path)
end

def a_post(path)
  a_request(:post, Canvas.endpoint + path)
end

def a_put(path)
  a_request(:put, Canvas.endpoint + path)
end

def stub_delete(path)
  stub_request(:delete, Canvas.endpoint + path)
end

def stub_get(path)
  stub_request(:get, Canvas.endpoint + path)
end

def stub_post(path)
  stub_request(:post, Canvas.endpoint + path)
end

def stub_put(path)
  stub_request(:put, Canvas.endpoint + path)
end

def fixture_path
  File.expand_path("../fixtures", __FILE__)
end

def fixture(file)
  File.new(fixture_path + '/' + file)
end