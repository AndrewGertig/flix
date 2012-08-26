require 'flix/configuration'
require 'flix/client'

module Flix
    extend Configuration
    
    def fake
      "class << self means I don't have to call self on Class level modules, they all get it. Calling self.client is actually for an instance"
    end
    
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
  
  puts "FLIX TIME USA"
end

Flix.reset #set defaults
# Flix.setup