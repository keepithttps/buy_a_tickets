class TicketPayment

	def choosing_bank
		puts "Введите номер банка из списка"
		banks = ["Сбер", "ВТБ","ТИНЬКОФФ", "Другой Банк"]
		banks.each_with_index { |b, i| puts "#{i += 1}.  #{b}"}
		bank = STDIN.gets.chomp.to_i

		if bank == 4 
			puts "Введите название своего банка"
			bank = STDIN.gets.chomp.to_s
			banks[3] = bank 
			bank = 4
		end

		until (1..4).include? bank  do
			puts "Не коректный вод данных: :("
		 	puts "Введите номер банка из списка"
			banks.each_with_index { |b, i| puts "#{i += 1}.  #{b}"}
			bank = STDIN.gets.chomp.to_i

		end
		return "Вы выброли банк #{banks[bank - 1]}"

	end

	def bank_card_number(number)
		@number = number
	end

	def number
		@number
	end 

	def surname(first_name, last_name)
		@first_name = first_name
		@last_name = last_name
	end

	def first_name
		@first_name
	end 

	def last_name
		@last_name
	end 

	def cvc(num)
		@num = num
	end 

	def num_cvc 
		@num 
	end

end


