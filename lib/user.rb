require 'bcrypt'
class User

	include DataMapper::Resource

	attr_reader :password
	attr_accessor :password_confirmation
	validates_confirmation_of :password 
	validates_uniqueness_of :email

	property :id, Serial
	property :email, String, :unique => true, :message => "This email is already taken"
	property :password_digest, Text

	def password=(password)  #why is there an = sign here?
		@password = password 	 #what exactly is goin on over here?
		self.password_digest = BCrypt::Password.create(password)
	end

end