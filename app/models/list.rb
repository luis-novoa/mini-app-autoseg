class List < ApplicationRecord
  before_save :check_ancestry, :record_parent_id
  after_destroy -> { destroy_empty(parent_list) }

  validates :description, presence: true, length: { minimum: 2, maximum: 100 }

  has_many :sublists, class_name: 'List', foreign_key: 'parent_list_id', dependent: :destroy
  belongs_to :parent_list, class_name: 'List', optional: true
  belongs_to :user, optional: true

  accepts_nested_attributes_for :sublists,
                                allow_destroy: true,
                                reject_if: ->(attributes) { attributes['description'].blank? }

  private

  def check_ancestry
    return unless parent_list

    ancestors_ids = parent_list.previous_lists_ids.split('_')
    return unless ancestors_ids.include?(id.to_s)

    errors.add(:parent_list_id, 'This list is an ancestor of the list you are trying to set up as parent.')
    throw(:abort)
  end

  def destroy_empty(record)
    return unless record

    record.destroy if record.sublists.empty?
  end

  def record_parent_id
    return unless parent_list_id

    self.previous_lists_ids = parent_list.previous_lists_ids + "#{parent_list_id}_"
    self.user_id = parent_list.user_id
  end
end
