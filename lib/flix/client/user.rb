module Flix
  class Client
    # Defines methods related to users
    module User
      
      def user
        url = "/users/#{uid}"
        puts "Get User from url: #{url}"
        response = from_response(:get, url, {output: "json"}, nil)
      end
      
  private

      def from_response(request_method, url, params={}, options={})
       response = send(request_method.to_sym, url, params, options)
      end

    end
  end
end
