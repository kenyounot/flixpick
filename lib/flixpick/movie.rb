class Movie
    attr_accessor :name, :genre
    @@all = []
    
    def initialize(name)
        @name = name
        save
    end



    def self.save
        @@all << self
    end

    def self.all
        @@all
    end

end