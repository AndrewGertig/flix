# require 'twitter/user'

module Twitter
  module API
    
    # def user(*args)
    #   options = args.extract_options!
    #   if user = args.pop
    #     options.merge_user!(user)
    #     object_from_response(Twitter::User, :get, "/1/users/show.json", options)
    #   end
    # end
    
    def user(*args)
      options = args.extract_options!
      if netflix_uid = args.pop
        client = shared_client(user)
        url = "/users/#{netflix_uid}"
        # puts "get this URL #{url}"
        
        response = from_response(:get, url, {output: "json"}, options)

        # response = client.get do |req|
        #   req.url url
        #   req.params['output'] = "json"
        # end

        puts "&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&"
        puts "RECEIVED FROM NETFLIX"
        puts "-------------HEADERS-----------------"
        puts "#{response.headers}"
        puts "----------------BODY--------------"
        puts "#{response.body}"
        puts "----------------------------------"

        return response.body
      end
    end
    
private
   
   # # @param klass [Class]
   # # @param request_method [Symbol]
   # # @param url [String]
   # # @param params [Hash]
   # # @param options [Hash]
   # # @return [Object]
   # def object_from_response(klass, request_method, url, params={}, options={})
   #   response = send(request_method.to_sym, url, params, options)
   #   klass.from_response(response)
   # end
   
   def from_response(request_method, url, params={}, options={})
     response = send(request_method.to_sym, url, params, options)
   end

  end
end