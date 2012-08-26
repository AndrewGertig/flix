module Flix
  class Client
    # Defines methods related to accounts
    module Disc

      # # Returns the currently logged in user.
      # def verify_credentials
      #   post('account/verify_credentials')
      # end
      
      # def user(*args)
      #   options = args.extract_options!
      #   if netflix_uid = args.pop
      #     url = "/users/#{netflix_uid}"
      # 
      #     response = from_response(:get, url, {output: "json"}, options)
      #   else
      #     response = "OOPS, you forgot the netflix_uid"
      #   end
      #   response
      # end
      # 
      # def self.queues(user)
      #   body = basic(user, "queues")
      # end
      # 
      # def self.disc_queue(user)
      #   body = basic(user, "queues/disc")
      # end

      def instant_queue(user)
        body = JSON.parse(base_user_request("queues/instant"))
        body["queue"]["queue_item"]
      end

      # def self.basic(user, category)
      #   client = shared_client(user)
      #   url = "/users/#{user.netflix_uid}/#{category}"
      # 
      #   response = client.get do |req|
      #     req.url url
      #     req.params['output'] = "json"
      #   end
      # 
      #   return response.body
      # end
      
  # private
  # 
  #     def from_response(request_method, url, params={}, options={})
  #      response = send(request_method.to_sym, url, params, options)
  #     end

    end
  end
end
