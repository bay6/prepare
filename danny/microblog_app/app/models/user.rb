class User < ActiveRecord::Base
	validates :name, presence: true, length: {maximum: 50}
	VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+[a-z\d.]*\.[a-z]+\z/i
	validates :email, format: { with: VALID_EMAIL_REGEX },
	                  presence: true,
	                  uniqueness: { case_sensitive: false }
	validates :password, :password_confirmation, length: { minimum: 6 }
	before_save { self.email = email.downcase }

	has_secure_password
end
