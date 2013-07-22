class Micropost < ActiveRecord::Base
  belongs_to :user
  validate :content, length: { maximun: 140 }
end
