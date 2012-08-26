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

    def endpoint_with_prefix
      api_endpoint + path_prefix
    end

    include Connection
    include Request
    include Authentication

    # Require client method modules after initializing the Client class in
    # order to avoid a superclass mismatch error, allowing those modules to be
    # Client-namespaced.
    require 'flix/client/account'
    require 'flix/client/user'
    require 'flix/client/bookmark'
    require 'flix/client/folder'

    include Flix::Client::Account
    include Flix::Client::User
    include Flix::Client::Bookmark
    include Flix::Client::Folder
  end
end
