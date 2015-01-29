class Rolodex
	attr_reader :contacts

	def initialize
		@contacts = []
		@id = 1000
	end

	def find(id)
		@contacts.find {|contact| contact.id == id}
	end

	def add_contact(contact)
	contact.id = @id
	@contacts << contact
	@id+= 1
	end
end 