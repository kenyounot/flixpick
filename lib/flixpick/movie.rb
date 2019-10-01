class Movie
    attr_accessor :name, :genre
    @@all = []
    
    def initialize(name)
        @name = name
        save
    end

    def self.add_movies_by_genre

    def self.save
        @@all << self
    end

    def self.all
        @@all
    end

end