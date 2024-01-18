# Подключаем все классы Программы

require_relative 'movie_poster.rb'
require_relative 'session_schedule.rb'
require_relative 'coosing_place.rb'
require_relative 'payments.rb'
require_relative 'mail_tickets.rb'

puts "Добро пожаловать в наш Кинотеатер!"
puts 
# puts films.size

choice = -1

until (choice >= 1) && (choice <= (MoviePoster.all_films.size))
	puts "Выберите Фильм который хотели бы посмотреть."

	MoviePoster.all_films.each_with_index  do |film, i| 
		i += 1
		puts " #{i}. #{film.film_name}"
		
	end

choice = gets.chomp.to_i
end

film = MoviePoster.all_films[choice - 1].film_name
	
puts "Вы выбрали Фильм #{film}"

ses = SessionSchedule.new

puts "Выберите дату посещения"
puts ses.show_dates
num = STDIN.gets.chomp.to_i
until (1..4).include? num 
	puts "Не правильный ввод"
	num = STDIN.gets.chomp.to_i
end
session_date = ses.visit_date(num)


puts "Выберите время сианса "
if num != 1
	ses.array_times
else
	ses.sessions_times.each_with_index { |x, i| puts " #{i + 1}. #{x}"}
end

	num = STDIN.gets.chomp.to_i
until (1..(ses.sessions_times.size)).include? num 
	puts "Не правильный ввод\n" +
	"Выберите правельное время сианса"
	num = STDIN.gets.chomp.to_i
end
session_time = ses.sessions_times[(num) - 1]


puts "Выберите пожалуйста ряд и место в зале"
place = Place.new

# Открываем файл, читаем 
place.reading_to_file

# и выводим все места в зале 
puts place.seat_auditorium 
	
puts "Введите ряд"
num = STDIN.gets.chomp.to_i
until (1..12).include? num 
	puts "Не правильный ввод\n" +
	"Выберите правельный ряд"
	num = STDIN.gets.chomp.to_i
end
puts place.set_row = num

puts "Введите место"
num = STDIN.gets.chomp.to_i
until (1..20).include? num 
	puts "Не правильный ввод\n" +
	"Выберите правельное место"
	num = STDIN.gets.chomp.to_i
end
puts place.set_chair = num

# С помощью цикла for праверяю ряд и место, введенное пользователям
for x in place.reading_to_file  

	#  Метод sum складывает место и ряд 
	# полученный результат сравнивает с элементом (place.reading_to_file) из файла data/ticekets_list.txt
	if place.sum == x.to_i

		puts "Вы выбронное место в зале к сожеленнию зането :("
		puts "Выберите пожалуйста еще раз"
		puts
		puts "Введите ряд"
		num = STDIN.gets.chomp.to_i
		until (1..12).include? num 
			puts "Не правильный ввод\n" +
			"Выберите правельный ряд"
			num = STDIN.gets.chomp.to_i
		end
		puts place.set_row = num

		puts "Введите место"
		num = STDIN.gets.chomp.to_i
		until (1..20).include? num 
			puts "Не правильный ввод\n" +
			"Выберите правельное место"
			num = STDIN.gets.chomp.to_i
		end
		puts place.set_chair = num
		
	end
end
# Записываю выбранные ряд и место в фаил data/ticekets_list.txt
place.occupied_chair_save


# Выстовляем цену согласно выбронному месту в зале 
case place.sum 

when 100..320
	total = 500
when 320..620
	total = 400
when 620..820
	total = 300
else
	total = 200
end

puts "Стоимость билета на #{film} = #{total}.руб"

# Вы бераем банки для оплаты билетов 
pay = TicketPayment.new

choosing_bank_card = pay.choosing_bank

puts " Введите номер банковской карты по аналогий (1234 1234 1234 1234)"
number_card = STDIN.gets.chomp.to_s
		until (number_card =~ /[0-9]/) == 0
			puts "Не правильный ввод\n\r" +
			"Введите правельный номер карты "
			number_card = STDIN.gets.chomp.to_i
		end
pay.bank_card_number(number_card)


puts "Введите Имя кому выдона банковская карта"
first_name = STDIN.gets.chomp.upcase
		until (first_name =~ /[A-Z]/) == 0
			puts "Не правильный ввод\n\r" +
			"Введите Имя Латиницей "
			first_name = STDIN.gets.chomp.to_s
		end


puts "Введите  Фамилия кому выдона банковская карта"
 last_name  = STDIN.gets.chomp.upcase.to_s
		until (last_name =~ /[A-Z]/) == 0
			puts "Не правильный ввод\n\r" +
			"Введите Фамилия Латиницей "
			last_name = STDIN.gets.chomp.to_s
		end
 pay.surname(first_name, last_name)



puts "В ведите трёх значный Защитный код CVV/CVC"
num = STDIN.gets.chomp.to_s
		until ((num =~ /[0-9]/) == 0) && (3 == num.size)
			puts "Не правильный ввод\n" +
			"Введите код CVV/CVC используя только цифры"
			num = STDIN.gets.chomp.to_s
		end
pay.cvc(num)


puts "#{choosing_bank_card}"
puts "#{pay.number[((pay.number.size) - 4)..-1]}"
puts "#{pay.first_name}" " #{pay.last_name}"
puts "Оплата прошла успешно: Cумма с писания #{total}.руб"



total_ticket = "* * * Кассовый чек * * *\n" +
		"Дата покупки: #{Time.now}.\n" +
		"Сеанс: #{film}\n" +
		"Дата сеанса: #{session_date}, время: #{session_time}\n" +
		"Ряд: #{place.row}. Место: #{place.chair}\n" +
		"           Стоимость билета ... #{total}.руб\n" + 
		"Номер карты оплаты  ..... #{pay.number[((pay.number.size) - 4)..-1]}\n"


puts
puts "Чек ..#{total_ticket}"

e_mail = ByEmail.new
e_mail.my_mail(total_ticket)

puts "Вы преобрели билеты успешно"
puts "Спасибо что выбрали нас!"

