require 'faraday_middleware'
require 'multi_json'
require 'flix/api'
require 'flix/configuration'
require 'simple_oauth'
require 'uri'

module Flix
  # Wrapper for the Netflix REST API
  class Client
    # @private
    attr_accessor *Configuration::VALID_OPTIONS_KEYS
    
    include Flix::API
    include Flix::Configuration

    # Initializes a new Client object / creates a new API
    #
    # @param options [Hash]
    # @return [Flix::Client]
    def initialize(options={})
      puts "Initialize the Flix Client!!!!!!!!!"
      options = Flix.options.merge(options)
      Configuration::VALID_OPTIONS_KEYS.each do |key|
        send("#{key}=", options[key])
      end
    end

  private

    # Returns a Faraday::Connection object
    #
    # @return [Faraday::Connection]
    def connection
      @connection ||= Faraday.new(@endpoint, @connection_options.merge(:builder => @middleware))
    end
    
    # Authentication hash
    #
    # @return [Hash]
    def authentication
      {
        :consumer_key => consumer_key,
        :consumer_secret => consumer_secret,
        :token => oauth_token,
        :token_secret => oauth_token_secret
      }
    end

    # Perform an HTTP request
    #
    # @raise [Flix::Error::ClientError, Flix::Error::DecodeError]
    def request(method, path, params={}, options={})
      uri = options[:endpoint] || @endpoint
      uri = URI(uri) unless uri.respond_to?(:host)
      uri += path
      request_headers = {}
      
      if credentials?
        authorization = auth_header(method, uri, params)
        request_headers[:authorization] = authorization.to_s
      end
      
      connection.url_prefix = options[:endpoint] || @endpoint
      
      response = connection.run_request(method.to_sym, path, nil, request_headers) do |request|
        unless params.empty?
          case request.method
          when :post, :put
            request.body = params
          else
            request.params.update(params)
          end
        end
        yield request if block_given?
      end.env
      
      # @rate_limit.update(response[:response_headers])
      
      response
      
    rescue Faraday::Error::ClientError
      # raise Flix::Error::ClientError
      raise "Faraday Oops".to_yaml
    rescue MultiJson::DecodeError
      # raise Flix::Error::DecodeError
      raise "MultiJson Oops".to_yaml
    end

    def auth_header(method, uri, params={})
      # When posting a file, don't sign any params
      signature_params = [:post, :put].include?(method.to_sym) && params.values.any?{|value| value.is_a?(File) || (value.is_a?(Hash) && (value[:io].is_a?(IO) || value[:io].is_a?(StringIO)))} ? {} : params
      SimpleOAuth::Header.new(method, uri, signature_params, credentials)
    end
  end
end
