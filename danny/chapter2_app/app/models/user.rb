class User < ActiveRecord::Base
  has_many :microposts

  validates :email, presence: true, 
                    format: { with: /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i }
end
