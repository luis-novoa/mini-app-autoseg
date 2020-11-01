require 'rails_helper'

RSpec.describe List, type: :model do
  context '.description' do
    subject { build(:list) }

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

  context '.previous_lists_ids' do
    subject { create(:list) }
    let(:sublist) { create(:sublist, parent_list: subject) }
    let(:sublist_child) { create(:sublist, parent_list: sublist) }

    it "stores all the ids of the list's ancestors" do
      expected_string = "#{subject.id}_#{sublist.id}_"
      expect(sublist_child.previous_lists_ids).to eq(expected_string)
    end
  end

  context 'associations' do
    subject { create(:list) }
    let!(:sublists) { create_list(:sublist, 2, parent_list: subject) }
    let!(:sublist_child) { create(:sublist, parent_list: sublists[0]) }

    it 'can have sublists' do
      expect(subject.sublists.count).to eq(2)
    end

    it 'can have a parent list' do
      expect(sublists[0].parent_list).to eq(subject)
    end

    it "can't have an ancestor list as sublist" do
      expect(subject.update(parent_list_id: sublist_child.id)).to eq(false)
    end
  end
end
