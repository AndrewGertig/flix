require 'faraday'
require 'flix/configurable'
# require 'flix/error/client_error'
# require 'flix/error/server_error'
require 'flix/identity_map'
# require 'flix/request/multipart_with_file'
# require 'flix/response/parse_json'
# require 'flix/response/raise_error'
require 'flix/version'

module Flix
  module Default
    ENDPOINT = 'http://api.netflix.com' unless defined? ENDPOINT
    # MEDIA_ENDPOINT = 'https://upload.flix.com' unless defined? MEDIA_ENDPOINT
    # SEARCH_ENDPOINT = 'https://search.flix.com' unless defined? SEARCH_ENDPOINT
    CONNECTION_OPTIONS = {
      :headers => {
        :accept => 'application/json',
        :user_agent => "Flix Ruby Gem #{Flix::VERSION}"
      },
      :open_timeout => 5,
      :raw => true,
      :ssl => {:verify => false},
      :timeout => 10,
    } unless defined? CONNECTION_OPTIONS
    IDENTITY_MAP = Flix::IdentityMap unless defined? IDENTITY_MAP
    MIDDLEWARE = Faraday::Builder.new(
      &Proc.new do |builder|
        # # Convert file uploads to Faraday::UploadIO objects
        # builder.use Flix::Request::MultipartWithFile
        # # Checks for files in the payload
        # builder.use Faraday::Request::Multipart
        
        builder.use Faraday::Request::OAuth, Flix::Configurable.keys
        # Convert request params to "www-form-urlencoded"
        builder.use Faraday::Request::UrlEncoded
        # Handle 4xx server responses
        # builder.use Flix::Response::RaiseError, Flix::Error::ClientError
        # # Parse JSON response bodies using MultiJson
        # builder.use Flix::Response::ParseJson
        # # Handle 5xx server responses
        # builder.use Flix::Response::RaiseError, Flix::Error::ServerError
        # Set Faraday's HTTP adapter
        builder.adapter Faraday.default_adapter
      end
    )

    class << self

      # @return [Hash]
      def options
        Hash[Flix::Configurable.keys.map{|key| [key, send(key)]}]
      end

      # @return [String]
      def consumer_key
        ENV['NETFLIX_CONSUMER_KEY']
      end

      # @return [String]
      def consumer_secret
        ENV['NETFLIX_CONSUMER_SECRET']
      end

      # @return [String]
      def oauth_token
        ENV['NETFLIX_OAUTH_TOKEN']
      end

      # @return [String]
      def oauth_token_secret
        ENV['NETFLIX_OAUTH_TOKEN_SECRET']
      end

      # @note This is configurable in case you want to use HTTP instead of HTTPS or use a Netflix-compatible endpoint.
      # @see http://status.net/wiki/Flix-compatible_API
      # @see http://en.blog.wordpress.com/2009/12/12/flix-api/
      # @see http://staff.tumblr.com/post/287703110/api
      # @see http://developer.typepad.com/typepad-flix-api/flix-api.html
      # @return [String]
      def endpoint
        ENDPOINT
      end

      # # @return [String]
      # def media_endpoint
      #   MEDIA_ENDPOINT
      # end
      # 
      # # @return [String]
      # def search_endpoint
      #   SEARCH_ENDPOINT
      # end

      # @return [Hash]
      def connection_options
        CONNECTION_OPTIONS
      end

      # @return [Flix::IdentityMap]
      def identity_map
        IDENTITY_MAP
      end

      # @note Faraday's middleware stack implementation is comparable to that of Rack middleware.  The order of middleware is important: the first middleware on the list wraps all others, while the last middleware is the innermost one.
      # @see https://github.com/technoweenie/faraday#advanced-middleware-usage
      # @see http://mislav.uniqpath.com/2011/07/faraday-advanced-http/
      # @return [Faraday::Builder]
      def middleware
        MIDDLEWARE
      end

    end
  end
end