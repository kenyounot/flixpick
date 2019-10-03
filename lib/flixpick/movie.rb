require 'pry'
require_relative 'scraper.rb'
require_relative 'genre.rb'

class Movie
    attr_accessor :name
    attr_reader :genre

    @@all = []

    def initialize(name, genre)
        @name = name
        self.genre = genre
        save
    end

    def genre=(genre)
        @genre = genre
        genre.movies << self unless genre.movies.include?(self)
    end

    def self.create(name)
        movie = new(name)
        movie.save 
        movie
    end

    def self.new_from_hash(hash)
        hash.each do |genres, movies|
            genre = Genre.find_by_name_or_create(genres.to_s)
            movies.each do |mov|
                new(mov, genre)
            end
        end
    end
    
    def self.find_by_name(name)
        self.all.detect {|mov| mov.name == name}
    end

    def self.find_by_name_or_create(name)
        find_by_name(name) || create(name)
    end

    def save
        self.class.all << self
    end

    def self.all
        @@all
    end

    def self.destory_all
        self.all.clear
    end
end


