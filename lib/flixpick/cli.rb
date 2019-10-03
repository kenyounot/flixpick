class Flixpick::CLI
    def call
        list_movie_genres
        menu
    end

    def list_movie_genres
        puts "
        +-+-+-+-+-+-+-+ +-+-+ +-+-+-+-+-+-+-+-+
        |W|e|l|c|o|m|e| |t|o| |F|l|i|x|p|i|c|k|
        +-+-+-+-+-+-+-+ +-+-+ +-+-+-+-+-+-+-+-+"
        puts

        @genres = Flixpick::MovieList.list_of_genre_names
        @genre_with_index = @genres.each.with_index(1).map {|genre, idx| "#{idx}. #{genre}"}
        puts @genre_with_index
    end

    def menu
      
        input = nil
        while input != "exit"
            puts
            puts "Enter number of genre you want a random movie from, type list to show the genres again," 
            puts "or type exit:"

            input = gets.strip.downcase
            puts
            if input.to_i > 0 && input.to_i <= @genres.length
                puts "Your random movie from the #{@genres[input.to_i-1].capitalize} genre is #{Flixpick::MovieList.random_movie(@genres[input.to_i-1])}"
            elsif input == "list"
                puts @genre_with_index
            elsif input == "exit"
                program_exit
            else
                puts "Selection not valid!"
            end
        end

    end

    def program_exit
        puts "Thank you for using Flixpick, Goodbye!"
    end
end



