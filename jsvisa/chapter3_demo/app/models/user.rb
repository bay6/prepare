class User < ActiveRecord::Base

  # Valiables 
  Min_name_length = 2
  Min_password_length = 6
  Max_name_length = 50
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z]+)*\.[a-z]+\z/i
  #VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i

  #before_save { self.email = email.downcase }
  before_save { email.downcase! }
  before_create :create_remember_token

  has_many :microposts, dependent: :destroy
  # valiable settings
  validates :name, presence: true, 
            length: { maximum: Max_name_length, minimum: Min_name_length }
  validates :email, presence: true, 
            format: { with: VALID_EMAIL_REGEX },
            uniqueness: { case_sensitive: false }
  validates :password, length: { minimum: Min_password_length }

  has_secure_password

  def User.new_remember_token
    SecureRandom.urlsafe_base64
  end

  def User.encrypt(token)
    Digest::SHA1.hexdigest(token.to_s)
  end

  private

    def create_remember_token
      self.remember_token = User.encrypt(User.new_remember_token)
    end

end

