require 'faraday'
require 'faraday_middleware'
Dir[File.expand_path('../../faraday/*.rb', __FILE__)].each{|f| require f}

module Canvas
  # @private
  module Connection
    private

    def connection(raw=false)
      options = {
        :headers => {'Content-Type' => "application/#{format}; charset=utf-8", 'User-Agent' => user_agent, 'Authorization' => "Bearer #{access_token}"},
        # :proxy => proxy,
        :ssl => {:verify => false},
        :url => endpoint,
      }

      Faraday::Connection.new(options) do |conn|
        conn.request :json
        
        conn.response :json, :content_type => /\bjson$/

        conn.use FaradayMiddleware::Mashify unless raw
        unless raw
          case format.to_s.downcase
          when 'json' then conn.use Faraday::Response::ParseJson
          end
        end
        # conn.use FaradayMiddleware::RaiseHttpException
        conn.adapter(adapter)
      end
    end
  end
end
