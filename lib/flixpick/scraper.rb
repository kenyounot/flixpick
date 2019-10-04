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

    def self.genre_list_scraper(urls)
        # hash of movie names with their tomato score, based on genre
        movie_genre_names = {}
        @movie_genre_urls = {}

        # iterates through each genre and their url link to top 100 list
        urls.each do |k,v|
            # opens each genre's top 100 list
            doc = Nokogiri::HTML(open(v), nil, 'utf-8')

            # array of genre titles
            movie_names = doc.css(".table").css('tr a')
            # array of genre scores
            movie_scores = doc.css(".table").css('.tMeterScore')
        
                
            # formats movie names; removes white space and junk characters
            movie_name_list = movie_names.collect {|movie| movie.text.strip}

            # iterates through movie scores of genre list and appends score to movie title
            movie_name_and_scores = movie_scores.each_with_index.collect do |score, idx|
                m_score = score.text.gsub("%", '')
                m_score[0] = ''
                movie_name_list[idx] + " // Tomato Score - #{m_score}%"
            end

            movie_urls = movie_names.collect do |movie|
                "https://rottentomatoes.com" + movie.attributes["href"].value
            end
            # adds movie+score as one string to hash
            movie_genre_names[k] = movie_name_and_scores
            @movie_genre_urls[k] = movie_urls
            
        end
        movie_genre_names
    end

    # def self.list_of_summary
    #     movie_summaries = {}
    #     @movie_genre_urls.each do |genre, url|
    #         url.each do |link|
    #             doc = Nokogiri::HTML(open(link))
    #             summary = doc.css(".panel-body #movieSynopsis").text.strip 
        
    #             movie_summaries[genre] = summary
    #         end
    #     end
        
    # end

    # returns list of genres
    def self.list_of_genres(url)
        genre_list = []
        index_page_scraper(url).each {|k,v| genre_list << k.to_s}
        genre_list
    end
end

Scraper.genre_list_scraper(Scraper.index_page_scraper("https://rottentomatoes.com/top"))
Scraper.list_of_summary


