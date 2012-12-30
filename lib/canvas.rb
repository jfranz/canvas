require "canvas/version"
require File.expand_path('../canvas/error', __FILE__)
require File.expand_path('../canvas/configuration', __FILE__)
require File.expand_path('../canvas/api', __FILE__)
require File.expand_path('../canvas/client', __FILE__)


module Canvas
  extend Configuration

  # Alias for Canvas::Client.new

  # @return [Canvass::Client]
  def self.client(options={})
    Canvas::Client.new(options)
  end

  # Delegate to Canvas::Client
  def self.method_missing(method, *args, &block)
    return super unless client.respond_to?(method)
    client.send(method, *args, &block)
  end

  # Delegate to Canvas::Client
  def self.respond_to?(method)
    return client.respond_to?(method) || super
  end
end