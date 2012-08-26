require 'flix/connection'
require 'flix/request'
require 'flix/authentication'

module Flix
  # Wrapper for the Flix REST API
  class Client
    # @private
    attr_accessor *Configuration::VALID_OPTIONS_KEYS

    alias :api_endpoint :endpoint
    # alias :api_version :version

    # Creates a new API
    def initialize(options={})
      options = Flix.options.merge(options)
      Configuration::VALID_OPTIONS_KEYS.each do |key|
        send("#{key}=", options[key])
      end
    end
    
    def base_user_request(resource)
      url = "/users/#{uid}/#{resource}"
      response = from_response(:get, url, {output: "json"}, {})
      return response
    end

    include Connection
    include Request
    include Authentication

    # Require client method modules after initializing the Client class in
    # order to avoid a superclass mismatch error, allowing those modules to be
    # Client-namespaced.
    require 'flix/client/disc'
    require 'flix/client/user'
    # require 'flix/client/bookmark'
    # require 'flix/client/folder'

    include Flix::Client::Disc
    include Flix::Client::User
    # include Flix::Client::Bookmark
    # include Flix::Client::Folder
    
    
private

    def from_response(request_method, url, params={}, options={})
     response = send(request_method.to_sym, url, params, options)
    end
  end
end
