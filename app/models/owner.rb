class Owner
	def name
		name = 'skilledar'
	end
	def birthdate
		birthdate = Date.new(1973, 8, 14)
	end
	def countdown
		today = Date.today
		birthday = Date.new(today.year, self.birthdate.month, self.birthdate.day)
		countdown = (birthday - today).to_i
		print "The value is #{countdown}"
		c = countdown
		
		if countdown == 0
			c = "0"
		elsif countdown < 0
			c = 365 + countdown
		end

		return c
	end
end
