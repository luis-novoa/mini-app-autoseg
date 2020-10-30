require 'rails_helper'

RSpec.describe User, type: :model do
  subject { build(:user) }

  context '.email' do
    it 'checks for presence' do
      subject.email = ''
      expect(subject.save).to eq(false)
    end

    it 'checks for format' do
      subject.email = 'user'
      expect(subject.save).to eq(false)
    end
  end

  context '.password' do
    it 'checks for presence' do
      subject.password = ''
      subject.password_confirmation = ''
      expect(subject.save).to eq(false)
    end

    it 'must have at least 6 characters' do
      password = Faker::Lorem.characters(number: 5)
      subject.password = password
      subject.password_confirmation = password
      expect(subject.save).to eq(false)
    end

    it 'must have at most 128 characters' do
      password = Faker::Lorem.characters(number: 129)
      subject.password = password
      subject.password_confirmation = password
      expect(subject.save).to eq(false)
    end
  end
end
