require 'digest/sha1'

class User < ActiveRecord::Base
validates_presence_of :name
validates_uniqueness_of :name


attr_accessor :password_confirmation
validates_confirmation_of :password

validate :password_non_blank


has_many :signatures

def self.authenticate(name, password)
	user = self.find_by_name(name)
	if user
		expected_password = encrypted_password(password, user.salt)
		if user.password != expected_password
			user = nil
		end
	end
	user
end


def password
	@password
end

def password=(pwd)
	@password = pwd
	return if pwd.blank?
	create_new_salt
	#self.password = User.encrypted_password(self.password, self.salt)
	write_attribute(:password, Digest::MD5.hexdigest(pwd))
end




private
	def password_non_blank
		errors.add(:password, "Missing password" ) if password.blank?
	end
	
	def create_new_salt
		self.salt = self.object_id.to_s + rand.to_s
	end

	def self.encrypted_password(password, salt)
		string_to_hash = password + "tttpass" + salt
		Digest::SHA1.hexdigest(string_to_hash)
	end

end
