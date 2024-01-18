class ByEmail
	require 'pony'

	def my_mail(body)
		@body = body

		my_mail = "m911-n@mail.ru" 

		 # "Введите пароль от вашей почты #{my_mail} для отправки письма"
		password = "DmGdE2aeY5ppApnbAhNx"

		puts "Укажите; Электронный адрес куда выслать билеты"
		send_to = STDIN.gets.chomp.to_s
			until (send_to =~ /^[a-z0-9 \- \_]+@[a-z0-9]+\.(com|ru)+/i) == 0
				puts "Не правильный ввод\n\r" +
				"Введите правельный Электронный адрес "
				send_to = STDIN.gets.chomp
			end

		# charset # In case you need to send in utf-8 or similar
		# А теперь используем gem pony для отправки билета 
		Pony.mail({
			:subject => "Проект Ruby 'Билеты в КИНО' ",
			:charset => "UTF-8", # использую кадировку писма "UTF-8"
			:body => @body,
			:to => send_to,
			:from => my_mail,
			:via => :smtp,
			:via_options => {
				:address => 'smtp.mail.ru',
				:port => '465',
				:tls => true,
				:user_name => my_mail,
				:password => password,
				:authentication => :plain
			}

		})
	end
end