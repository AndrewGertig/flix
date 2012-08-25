require 'flix/client'
require 'flix/configurable'

module Flix
  class << self
    include Flix::Configurable
    
    # Alias for Flix::Client.new (via Instapaper gem)
    #
    # @return [Flix::Client]
    def self.client(options={})
      Flix::Client.new(options)
    end

    # Delegate to Flix::Client
    def self.method_missing(method, *args, &block)
      return super unless client.respond_to?(method)
      client.send(method, *args, &block)
    end

    def self.respond_to?(method, include_private = false)
      client.respond_to?(method, include_private) || super(method, include_private)
    end

    # Custom error class for rescuing from all Flix errors
    class Error < StandardError; end

  #   # Delegate to a Flix::Client
  #   #
  #   # @return [Flix::Client]
  #   def client
  #     if @client && @client.cache_key == options.hash
  #       @client
  #     else
  #       @client = Flix::Client.new(options)
  #     end
  #   end
  # 
  #   def respond_to_missing?(method_name, include_private=false); client.respond_to?(method_name, include_private); end if RUBY_VERSION >= "1.9"
  #   def respond_to?(method_name, include_private=false); client.respond_to?(method_name, include_private) || super; end if RUBY_VERSION < "1.9"
  # 
  # private
  # 
  #   def method_missing(method_name, *args, &block)
  #     return super unless client.respond_to?(method_name)
  #     client.send(method_name, *args, &block)
  #   end

  end
  
  puts "FLIX TIME USA"
end

Flix.reset #set defaults
# Flix.setup