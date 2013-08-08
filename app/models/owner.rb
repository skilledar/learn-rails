class Owner
	def name
		name = 'skilledar'
	end
	def birthdate
		birthdate = Date.new(1973, 8, 8)
	end
	def countdown
		today = Date.today
		birthday = Date.new(today.year, self.birthdate.month, self.birthdate.day)
		countdown = (birthday - today).to_i
		if countdown == 0
			countdown = "0"
		elsif countdown < 0
			countdown = 365 + countdown 
		end
	end
end