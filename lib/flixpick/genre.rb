class Genre

    attr_accessor :name, :movies

    @@all = []

    def initialize(name)
        @name = name
        @movies = []
    end

    def self.create(name)
        genre = new(name)
        genre.save 
        genre
    end

    def self.find_by_name(name)
        self.all.detect {|gen| gen.name == name}
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

end
