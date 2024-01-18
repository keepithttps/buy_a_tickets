class MoviePoster
	attr_accessor :film_name, :director_film, :film_genre, :duration

	def initialize(film_name, director_film, film_genre, duration )
		@film_name = film_name
		@director_film = director_film
		@film_genre = film_genre
		@duration = duration
	end

	class << self
		attr_reader :all_films, :film  

		def all_films

			@films = []
			film = MoviePoster.new('Супермозг', "Пол Луис Мейер", "12+ анимация", "01:24")
			@films << film

			film = MoviePoster.new('Человек ниоткуда', "Ренат Давлетьяров", "12+ триллер, приключения, фантастика", "01:39")
			@films << film

			film = MoviePoster.new('Повелитель ветра', "Игорь Волошин", "12+ биография, приключения, драма", "01:39")
			@films << film

			film = MoviePoster.new('По щучьему велению', "Александр Войтинский", "6+ сказка, приключения, фэнтези", "01:57")
			@films << film 

			return @films

		end

		def film
			film = @films
		end
	end
end
