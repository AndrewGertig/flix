module Flix
  class Client
    # Defines methods related to users
    module User
      
      def user
        response = from_response(:get, "/users/#{uid}", {output: "json"}, {})
        response[:body]["user"]
      end
      
      private

      def from_response(request_method, url, params={}, options={})
       response = send(request_method.to_sym, url, params, options)
      end

    end
  end
end
