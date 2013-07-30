class User < ActiveRecord::Base
  # Valiables 
  Min_name_length = 2
  Max_name_length = 50
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i

  # valiable settings
  validates :name, presence: true, 
            length: { maximum: Max_name_length, minimum: Min_name_length }
  validates :email, presence: true, 
            format: { with: VALID_EMAIL_REGEX },
            uniqueness: { case_sensitive: false }

  before_save { self.email = email.downcase }
end
