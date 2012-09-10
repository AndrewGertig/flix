require 'multi_json'
require 'simple_oauth'
require 'uri'

module Flix
  # Defines HTTP request methods
  module Request
    
    # Perform an HTTP DELETE request
    def delete(path, params={}, options={})
      request(:delete, path, params, options)
    end

    # Perform an HTTP GET request
    def get(path, params={}, options={})
      request(:get, path, params, options)
    end

    # Perform an HTTP POST request
    def post(path, params={}, options={})
      request(:post, path, params, options)
    end

    # Perform an HTTP UPDATE request
    def put(path, params={}, options={})
      request(:put, path, params, options)
    end

  private

    # # Perform an HTTP request
    # def request(method, path, options, raw=false)
    #   response = connection(raw).send(method) do |request|
    #     request.path = path_prefix + path
    #     request.body = options unless options.empty?
    #   end
    #   raw ? response : response.body
    # end
    

    # Perform an HTTP request
    #
    # @raise [Flix::Error::ClientError, Flix::Error::DecodeError]
    def request(method, path, params={}, options={})
      uri = options[:endpoint] || @endpoint
      uri = URI(uri) unless uri.respond_to?(:host)
      uri += path

      request_headers = {}

      if authenticated?
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
  
      # puts "The API response is #{response}"
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
      SimpleOAuth::Header.new(method, uri, signature_params, authentication)
    end

  end
end
