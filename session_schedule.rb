class SessionSchedule

	# Выбор даты сеанса 
		require 'date'
		@@day_week = ['Воскресенье', 'Понедельник', 'Вторник', 'Среда', 'Четверг', 'Пятница', 'Суббота', 'Воскресенье', 'Понедельник', 'Вторник']
		@@months = ['Январь', 'Февраль', 'Март', 'Апрель', 'Май', 'Июнь', 'Июль', 'Август', 'Сентябрь', 'Октябрь', 'Ноябрь', 'Декабрь' ]
		@@array_time = ['10:30', '12:50', '14:36', '15:45', '16:40', '18:50', '20:30', '21:55', '23:55' ]


	def today
		d = Time.new
		m = @@months[(d.strftime("%B").to_i)]
		d.strftime("%d.#{m}.%Y.года")
	end	


	def show_dates
		@@visit_dates = {}

		# Создаем обьект времени date
		date = Date.today


		# Создаем переменную с компонентом времени w_day в формате от 0 до 6:
		# Где 0 это Воскресенье, а 6 Суббота
		w_day = (date).strftime('%w').to_i 


		# Создаем переменную с компонентом времени monht = в формате названия месяца полностью 
		month = @@months[(date).strftime('%B').to_i]


		# Создаем переменную с компонентом времени date_of_month = в формате число месяца 
	    date_of_month = (date).strftime('%d').to_i


		@@day_week.slice(w_day, 4).each_with_index  do  |day, i|
			i += 1
			if (date).strftime('%d').to_i == date_of_month
				 puts "#{i}. Сегодня #{day},  #{date_of_month } #{month}"
				 @@visit_dates[i] = "Сегодня #{day},  #{date_of_month } #{month}"
				 date_of_month += 1
				 
			elsif (date).strftime('%d').to_i - (date_of_month) == -1
				puts "#{i}. Завтра  #{day}, #{date_of_month} #{month}"
				@@visit_dates[i] = "Завтра #{day},  #{date_of_month } #{month}"
				 date_of_month += 1

			else			
				puts  "#{i}. #{day} #{(date_of_month) } #{month}"
				 @@visit_dates[i] = " #{day},  #{date_of_month } #{month}"
				 date_of_month += 1
			end 
		end
		return 
	end 

	def visit_date(number)
		return @@visit_dates[number]
	end

	# Выбор время сеанса 
	def sessions_times
		@pick_time = []

		t = Time.new
		 
		@pick_time = @@array_time.drop_while { |x| "#{x}" if  x < (t.strftime("%H:%M"))}
		return @pick_time
	end

	def array_times 
		@@array_time.each_with_index { |x, i| puts " #{i + 1}. #{x}"}
		
	end
end 
