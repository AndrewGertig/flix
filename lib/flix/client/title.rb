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
      
      # Possible expand aliases
      # *************************
      # @title
      # @box_art
      # @synopsis
      # @short_synopsis
      # @format_availability
      # @screen_formats
      # @cast
      # @directors
      # @languages_and_audio
      # @awards
      # @similars
      # @bonus_materials
      # @seasons
      # @episodes
      # @discs
      def expanded_search(term)
        res = base_search({term: term, expand: "@title,@box_art"})
        res[:body]
      end
      
      def movie(movie_id, *expands)
        expand = "#{expands.join(',')}"
        res = base_movie(movie_id: movie_id, expand: expand)
        res[:body]
      end
      
      def series(series_id, *expands)
        expand = "#{expands.join(',')}"
        res = base_series(series_id: series_id, expand: expand)
        res[:body]
      end
      
      def program(program_id, *expands)
        expand = "#{expands.join(',')}"
        res = base_program(program_id: program_id, expand: expand)
        res[:body]
      end

    end
  end
end
