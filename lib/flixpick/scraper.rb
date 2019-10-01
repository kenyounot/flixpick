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
        movie_names_and_scores = {}

        urls.each do |k,v|
            # opens each genre list url
            doc = Nokogiri::HTML(open(v), nil, 'utf-8')

            # array of genre titles
            movie_names = doc.css(".table").css('tr a')
            # array of genre scores
            movie_scores = doc.css(".table").css('.tMeterScore')

            # formatting movie names
            movie_name_list = movie_names.collect {|movie| movie.text.strip}
            # formatting the movie scores

            movie_name_and_scores = movie_scores.each_with_index.collect do |score, idx|
                m_score = score.text.gsub("%", '')
                m_score[0] = ''
                movie_name_list[idx] + " // Tomato Score - #{m_score}%"
            end 

            movie_names_and_scores[k] = movie_name_and_scores
            # Movie Title - doc.css(".table").css('tr a').first.text.strip
            # Score - doc.css(".table").css('.tMeterScore').text.gsub("%", "")
            
        end
        binding.pry
    end



    def self.list_of_genres(url)
        genre_list = []
        index_page_scraper(url).each {|k,v| genre_list << k.to_s}
        genre_list
    end

end

Scraper.genre_list_scraper(Scraper.index_page_scraper("https://rottentomatoes.com/top"))