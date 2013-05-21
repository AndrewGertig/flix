require 'flix/connection'
require 'flix/request'
require 'flix/authentication'

module Flix
  # Wrapper for the Flix REST API
  class Client
    # @private
    attr_accessor *Configuration::VALID_OPTIONS_KEYS

    alias :api_endpoint :endpoint

    # Creates a new API
    def initialize(options={})
      options = Flix.options.merge(options)
      Configuration::VALID_OPTIONS_KEYS.each do |key|
        send("#{key}=", options[key])
      end
    end
    
    def base_user_request(resource)
      response = from_response(:get, "/users/#{uid}/#{resource}", {output: "json"}, {})
      return response
    end
    
    def base_search(params)
      response = from_response(:get, "/catalog/titles", {output: "json", v: "2.0"}.merge(params), {})
      return response
    end
    
    def base_movie(params)
      movie_id = params[:movie_id]
      from_response(:get, "/catalog/titles/movies/#{movie_id}", {output: "json", v: "2.0"}.merge(params), {})
    end
    
    def base_series(params)
      series_id = params[:series_id]
      from_response(:get, "/catalog/titles/series/#{series_id}", {output: "json", v: "2.0"}.merge(params), {})
    end
    
    def base_season(params)
      series_id = params[:series_id]
      season_id = params[:season_id]
      from_response(:get, "/catalog/titles/series/#{series_id}/seasons/#{season_id}", {output: "json", v: "2.0"}.merge(params), {})
    end
    
    def base_program(params)
      program_id = params[:program_id]
      from_response(:get, "/catalog/titles/programs/#{program_id}", {output: "json", v: "2.0"}.merge(params), {})
    end
    

    include Connection
    include Request
    include Authentication

    # Require client method modules after initializing the Client class in
    # order to avoid a superclass mismatch error, allowing those modules to be
    # Client-namespaced.
    require 'flix/client/disc'
    require 'flix/client/user'
    require 'flix/client/title'

    include Flix::Client::Disc
    include Flix::Client::User
    include Flix::Client::Title
    
    
private

    def from_response(request_method, url, params={}, options={})
     response = send(request_method.to_sym, url, params, options)
    end
  end
end
