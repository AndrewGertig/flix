module Flix
  class Client
    # Defines methods related to users
    module User
      
      def user(*args)
        puts "Go get a Netflix User"
        options = args.extract_options!
        if netflix_uid = args.pop
          url = "/users/#{netflix_uid}"

          response = from_response(:get, url, {output: "json"}, options)
          
          puts "the User Response: #{response}"

          return response
        end
      end
      

      # Gets an OAuth access token for a user.
      def access_token(username, password)
        response = post('oauth/access_token', { :x_auth_username => username, :x_auth_password => password, :x_auth_mode => "client_auth"}, true)
        Hash[*response.body.split("&").map {|part| part.split("=") }.flatten]
      end
      
      
      private

          def from_response(request_method, url, params={}, options={})
           response = send(request_method.to_sym, url, params, options)
          end

    end
  end
end
