module Flix
  module API
    
    def user(*args)
      options = args.extract_options!
      if netflix_uid = args.pop
        client = shared_client(user)
        url = "/users/#{netflix_uid}"
        # puts "get this URL #{url}"
        
        response = from_response(:get, url, {output: "json"}, options)
        puts "The Response from User #{response}"
        return response
      end
    end
    
private
   
    def from_response(request_method, url, params={}, options={})
     response = send(request_method.to_sym, url, params, options)
    end

  end
end