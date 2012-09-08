require 'faraday_middleware'

module Flix
  # @private
  module Connection
    private

    def connection(raw=false)
      merged_options = connection_options.merge({
        :headers => {
          'Accept' => "application/json",
          'User-Agent' => user_agent
        },
        :ssl => {:verify => false},
        :url => api_endpoint
      })
      
      Faraday.new(merged_options) do |builder|
        if authenticated?
          builder.use Faraday::Request::OAuth, authentication
        else
          builder.use Faraday::Request::OAuth, consumer_tokens
        end
        builder.use Faraday::Request::UrlEncoded
        # builder.use Faraday::Response::Rashify unless raw
        builder.use Faraday::Response::ParseJson unless raw
        builder.adapter(adapter)
      end
    end
  end
end
