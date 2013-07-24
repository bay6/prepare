class Micropost < ActiveRecord::Base
  belongs_to :user
  validates :content, length: { maximum: 140}
  validates :user_id, presence: true
  validate :user_is_not_exist_or_is_race

  private
    def user_is_not_exist_or_is_race
      if !User.ids.include?(user_id) || User.find(user_id).name == "race"
        errors.add(:user, 'user is not exist or can not be race')
      end
    end
end
