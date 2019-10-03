require_relative 'scraper.rb'
require 'pry'
require_relative 'movie.rb'
require_relative 'genre.rb'

class MovieList
    
    def self.create_movie_list_by_genre(genre)
        Genre.find_by_name(genre).movies.collect {|movie| movie.name}
    end

    def self.random_movie_by_genre(genre)
        create_movie_list_by_genre(genre).sample
    end
end

Movie.new_from_hash(Scraper.genre_list_scraper(Scraper.index_page_scraper("https://rottentomatoes.com/top")))

binding.pry