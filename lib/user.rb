require 'bcrypt'
class User

	include DataMapper::Resource

	attr_reader :password
	attr_accessor :password_confirmation
	validates_confirmation_of :password 

	property :id, Serial
	property :email, String
	property :password_digest, Text

	def password=(password)  #why is there an = sign here?
		@password = password 	 #what exactly is goin on over here?
		self.password_digest = BCrypt::Password.create(password)
	end

end