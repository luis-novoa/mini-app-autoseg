class Task < ApplicationRecord
  validates :description, presence: true, length: { minimum: 2, maximum: 100 }

  belongs_to :list
end
