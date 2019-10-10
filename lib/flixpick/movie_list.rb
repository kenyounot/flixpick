
class Flixpick::MovieList
    # creates new instances of movies and generes and stores it in instance variable
    @movie_data = Movie.new_from_hash(Scraper.genre_list_scraper(Scraper.index_page_scraper("https://rottentomatoes.com/top")))


    def self.list_of_genre_names
        Genre.all.collect {|g| g.name}
    end

    def self.random_movie(input)
        create_movie_list_by_genre(input).sample
    end

    def self.create_movie_list_by_genre(genre)
        Genre.find_by_name(genre).movies.collect {|movie| movie.name}
    end
end



