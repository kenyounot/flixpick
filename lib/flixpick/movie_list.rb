require_relative 'scraper.rb'
require 'pry'

class MovieList
    attr_accessor :genres, :nam

    def self.create_from_hash(genres_hash)
        genres_hash.each do |genre, values|
            MovieList.new
            
        end
    end
end

