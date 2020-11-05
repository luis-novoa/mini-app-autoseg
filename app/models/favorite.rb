class Favorite < ApplicationRecord
  before_validation :create_user_list
  before_save :check_for_sublist

  validates :user_list, uniqueness: true

  belongs_to :user
  belongs_to :list

  private

  def check_for_sublist
    return unless list.parent_list

    errors.add(:list_id, 'It is forbidden to favorite sublists.')
    throw(:abort)
  end

  def create_user_list
    self.user_list = "#{user.id}_#{list.id}"
  end
end
