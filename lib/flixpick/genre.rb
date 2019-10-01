require 'pry'
require_relative 'scraper.rb'

class Genre
    attr_accessor :name
    @@all = []

    def initialize(name)
        @name = name
        @@all << self
    end

    def self.create_from_hash(hash)
        hash.each do |g, v|
            genre = Genre.new(g.to_s)
        end
    end

    def self.save
        @@all << self
    end

    def self.all
        @@all
    end
end

Genre.create_from_hash(Scraper.index_page_scraper("https://rottentomatoes.com/top"))
binding.pry
puts Genre.all