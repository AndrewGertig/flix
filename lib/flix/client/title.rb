module Flix
  class Client
    # Defines methods related to show Titles
    module Title
      
      def search(params)
        res = base_search(params)
        res[:body]
      end

    end
  end
end
