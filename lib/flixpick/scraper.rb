require 'pry'
require 'nokogiri'
require 'open-uri'

class Scraper

    def self.index_page_scraper(url)
        genre_url_list = {}
        junk_words = ["Top", "100", "Movies", "&"]

        doc = Nokogiri::HTML(open(url))
        top_list = doc.css(".panel-body li")

        top_list.each do |genre|
            stripped_genre =  (genre.text.strip.split - junk_words)[0].downcase
            url = genre.css('a')[0]["href"]
            
            genre_url_list[stripped_genre.to_sym] = ("https://rottentomatoes.com" + url)
        end

        genre_url_list
    end
    # returns genre list and the url to each movie and its info
    def self.genre_list_scraper(url)
        url_hash = Scraper.index_page_scraper(url)
        movie_url_list = {}

        # iterates through each genre and their url link to top 100 list
        url_hash.each do |k,v|
            # opens each genre's top 100 list
            doc = Nokogiri::HTML(open(v), nil, 'utf-8')

            # array of movies and their attributes
            movie_list = doc.css(".table").css('tr a')
        
            movie_urls = movie_list.collect do |movie|
                "https://rottentomatoes.com" + movie.attributes["href"].value
            end
        
            movie_url_list[k] = movie_urls  
        end
        movie_url_list
    end

    def self.movie_info_scraper(url)
        url_hash = genre_list_scraper(url)

        genre_and_movies = {}

        url_hash.each do |genre,urls|
            movie_info = []
            urls.each do |url|
                doc = Nokogiri::HTML(open(url))

                movie_name = doc.css("#topSection > div.col-sm-17.col-xs-24.score-panel-wrap > div.mop-ratings-wrap.score_panel.js-mop-ratings-wrap > h1").text
                movie_score = doc.css("#tomato_meter_link > span.mop-ratings-wrap__percentage").text.strip
                movie_bio = doc.css("#movieSynopsis").text.strip
                movie_date = doc.css("#mainColumn > section.panel.panel-rt.panel-box.movie_info.media > div > div > ul > li:nth-child(5) > div.meta-value > time").text

                movie_info << {movie_name => 
                                {:score => movie_score, :bio => movie_bio, :date => movie_date}
                              }

        
            end
            round = 1
            puts "Round #{round}"
            round += 1
           
            
            genre_and_movies[genre] = movie_info
        end
        binding.pry
    end

end 


Scraper.movie_info_scraper("https://rottentomatoes.com/top")
