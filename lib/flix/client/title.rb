module Flix
  class Client
    # Defines methods related to show Titles
    module Title
      
      def search(term)
        res = base_search(term: term)
        res[:body]
      end

    end
  end
end
