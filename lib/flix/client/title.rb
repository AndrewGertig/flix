module Flix
  class Client
    # Defines methods related to show Titles
    module Title
      
      def basic_search(params)
        res = base_search(params)
        res[:body]
      end
      
      def search(term)
        res = base_search(term: term)
        res[:body]
      end
      
      def expanded_search(term)
        res = base_search({term: term, expand: "@title,@box_art")
        res[:body]
      end

    end
  end
end
