class Micropost < ActiveRecord::Base
  belongs_to :user
  validates :content, length: { maximum: 140 }
  validates_format_of :email, :with => /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i
end
