require 'rails_helper'

RSpec.describe Task, type: :model do
  context '.description' do
    subject { build(:task) }

    it 'must be present' do
      subject.description = ''
      expect(subject.save).to eq(false)
    end

    it 'must have at least 2 characters' do
      subject.description = Faker::Lorem.characters(number: 1)
      expect(subject.save).to eq(false)
    end

    it 'must have at most 100 characters' do
      subject.description = Faker::Lorem.characters(number: 101)
      expect(subject.save).to eq(false)
    end
  end
end
