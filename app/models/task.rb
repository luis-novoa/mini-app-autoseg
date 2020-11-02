class Task < ApplicationRecord
  after_destroy -> { destroy_empty(list) }

  validates :description, presence: true, length: { minimum: 2, maximum: 100 }

  belongs_to :list
end
