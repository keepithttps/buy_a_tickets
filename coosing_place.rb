class Place
	attr_reader :row, :chair 
	
	current_path = File.dirname(__FILE__)
	@@file_path = current_path + "/data/ticket_list.txt"		

	def set_row=(row)
		@row = row
	end

	def set_chair=(chair)
		@chair = chair
	end

	def sum 
		((@row * 100) + @chair)
	end 


	# Сохроняем занетое место в файл 
	def occupied_chair_save
		@held_chair = []
		
		# Записываем ряд и место в зале в файл
		if File.exist?(@@file_path) 
			file = File.new(@@file_path, "a:UTF-8")
			@held_chair = "#{(@row * 100) + (@chair)} "
			file.print (@held_chair)
			file.close
		else
			puts "Файл не найден"
		end
		
	end
	
	# читаем файл 
	
	def reading_to_file
		arr_chair = []
		
		if File.exist?(@@file_path)
			file = File.new(@@file_path, "r:UTF-8")
			arr_chair = file.read
			file.close
			@@occupied_chair = arr_chair.split
		else
			puts "Файл не найден"
		end 
	end


	# Выводим сам зал с местами занятами (**), и пустыми 
	def seat_auditorium

		screen = "    * * * *--------------------------------------Э-К-Р-А-Н-------------------------------------* * * *"
		puts screen
		puts
		puts 
		puts
		puts
		row_w = 1
		while row_w <= 12

			chair_w = 1
			print format( "  Ряд %#{3}d: ", row_w) 

			while chair_w <= 20

				@@occupied_chair.each do |i|
					
					if  (row_w * 100) + chair_w == i.to_i
						print  format("%#{4}s", ("**"))
						chair_w += 1

					elsif chair_w == 21
						break

					end
						
				end
					break if chair_w == 21
					print  format("%#{4}s", chair_w )
					chair_w += 1

			end

		puts format( "   :Ряд %#{3}d"  , row_w )  
		row_w += 1
			
		end
		
	end 




end 
