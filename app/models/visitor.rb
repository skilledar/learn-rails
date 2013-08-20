require 'pp'

class Visitor < ActiveRecord::Base
	has_no_table
	column :email, :string
	column :first_name, :string
	column :last_name, :string
	column :subscription, :string

	validates_presence_of :email
	validates_format_of :email, :with => /\A[-a-z0-9_+\.]+\@([-a-z0-9]+\.)+[a-z0-9]{2,4}\z/i

	def subscribe
		
		gb = Gibbon::API.new(ENV["MAILCHIMP_API_KEY"])

		# returns a hash table with key = "data" and value = "array of all subscribers"
		values = gb.lists.members({:id => ENV['MAILCHIMP_LIST_ID']})["data"]

		values.each do |val|
			puts val["email"]
		end

		result = gb.listSubscribe({:id => ENV['MAILCHIMP_LIST_ID'], 
			:email_address => self.email, 
			:update_existing => false, 
			:double_optin => false, 
			:send_welcome => true, 
			:merge_vars => {'FNAME' => self.first_name, 'LNAME' => self.last_name, 
					'MERGE3' => self.subscription, 'MERGE4' => DateTime.now}}
			)

		p "result = ", result
		pp result
		
		Rails.logger.info("Subscribed #{self.email} to MailChimp") if result
		rescue Gibbon::MailChimpError => e
		Rails.logger.info("MailChimp subscribe failed for #{self.email}: " + e.message)
	end
end