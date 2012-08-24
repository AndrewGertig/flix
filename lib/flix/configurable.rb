require 'flix/default'

module Flix
  module Configurable
    attr_writer :consumer_key, :consumer_secret, :oauth_token, :oauth_token_secret
    attr_accessor :endpoint, :connection_options, :middleware,  :identity_map
    # attr_accessor :media_endpoint, :search_endpoint,
    class << self

      def keys
        @keys ||= [
          :consumer_key,
          :consumer_secret, 
          :oauth_token,
          :oauth_token_secret,
          :endpoint,
          :connection_options,
          :middleware,
          :identity_map,
          # :media_endpoint,
          # :search_endpoint,
        ]
      end

    end

    # Convenience method to allow configuration options to be set in a block
    def configure
      yield self
      self
    end

    # @return [Boolean]
    def credentials?
      credentials.values.all?
    end

    # @return [Fixnum]
    def cache_key
      options.hash
    end

    def reset!
      Flix::Configurable.keys.each do |key|
        instance_variable_set(:"@#{key}", Flix::Default.options[key])
      end
      self
    end
    alias setup reset!

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
    def options
      Hash[Flix::Configurable.keys.map{|key| [key, instance_variable_get(:"@#{key}")]}]
    end

  end
end