class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true

  private

  def destroy_empty(record)
    return unless record

    record.destroy if record.sublists.empty? && record.tasks.empty?
  end
end
