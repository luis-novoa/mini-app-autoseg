require 'rails_helper'

RSpec.describe User, type: :model do
  subject { build(:user) }

  context '.email' do
    it 'must be present' do
      subject.email = ''
      expect(subject.save).to eq(false)
    end

    it 'must follow format' do
      subject.email = 'user'
      expect(subject.save).to eq(false)
    end
  end

  context '.password' do
    it 'must be present' do
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

  it 'can have many lists' do
    create_list(:list, 2, user: subject)
    expect(subject.lists.count).to eq(2)
  end
end
