# require 'flix/default'

module Flix
  module Configuration
    # attr_writer :consumer_key, :consumer_secret, :oauth_token, :oauth_token_secret
    # attr_accessor :endpoint, :connection_options, :middleware,  :identity_map, :user_agent
    # attr_accessor :media_endpoint, :search_endpoint
    
    # An array of valid keys in the options hash when configuring a {Instapaper::API}
    VALID_OPTIONS_KEYS = [
      :consumer_key,
      :consumer_secret,
      :oauth_token,
      :oauth_token_secret,
      :endpoint,
      :user_agent,
      :connection_options].freeze

    # By default, don't set an application key
    DEFAULT_CONSUMER_KEY = nil

    # By default, don't set an application secret
    DEFAULT_CONSUMER_SECRET = nil

    # The endpoint that will be used to connect if none is set
    DEFAULT_ENDPOINT = 'http://api.netflix.com'.freeze

    # The version of the API.
    # DEFAULT_VERSION = '1'
    # DEFAULT_PATH_PREFIX = 'api/' + DEFAULT_VERSION + '/'

    # By default, don't set a user oauth token
    DEFAULT_OAUTH_TOKEN = nil

    # By default, don't set a user oauth secret
    DEFAULT_OAUTH_TOKEN_SECRET = nil

    # The user agent that will be sent to the API endpoint if none is set
    DEFAULT_USER_AGENT = "Flix Ruby Gem #{Flix::VERSION}".freeze

    DEFAULT_CONNECTION_OPTIONS = {}
    
    # @private
    attr_accessor *VALID_OPTIONS_KEYS

    # When this module is extended, set all configuration options to their default values
    def self.extended(base)
      base.reset
    end

    # Convenience method to allow configuration options to be set in a block
    def configure
      yield self
    end

    # Create a hash of options and their values
    def options
      options = {}
      VALID_OPTIONS_KEYS.each{|k| options[k] = send(k) }
      options
    end

    # Reset all configuration options to defaults
    def reset
      self.consumer_key       = DEFAULT_CONSUMER_KEY
      self.consumer_secret    = DEFAULT_CONSUMER_SECRET
      self.endpoint           = DEFAULT_ENDPOINT
      self.oauth_token        = DEFAULT_OAUTH_TOKEN
      self.oauth_token_secret = DEFAULT_OAUTH_TOKEN_SECRET
      self.user_agent         = DEFAULT_USER_AGENT
      # self.version            = DEFAULT_VERSION
      self.connection_options = DEFAULT_CONNECTION_OPTIONS
      self
    end

  private

    # @return [Hash]
    def credentials
      {
        :consumer_key => @consumer_key,
        :consumer_secret => @consumer_secret,
        :token => @oauth_token,
        :token_secret => @oauth_token_secret,
      }
    end

    # @return [Hash]
    # def options
    #   Hash[Flix::Configuration.keys.map{|key| [key, instance_variable_get(:"@#{key}")]}]
    # end

  end
end