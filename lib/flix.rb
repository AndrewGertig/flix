require 'flix/configuration'
require 'flix/client'

module Flix
  extend Configuration

  # Alias for Flix::Client.new
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
end
