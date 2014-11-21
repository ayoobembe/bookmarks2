require 'bcrypt'
class User

	include DataMapper::Resource

	property :id, Serial
	property :email, String
	property :password_digest, Text

	def password=(password)  #why is there an = sign here?
		self.password_digest = BCrypt::Password.create(password)
	end

end