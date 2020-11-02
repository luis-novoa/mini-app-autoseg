require 'rails_helper'

RSpec.describe Favorite, type: :model do
  subject { create(:favorite) }
  let(:user) { subject.user }
  let(:list) { subject.list }
  let(:sublist) { create(:sublist, parent_list: list) }
  let(:new_favorite) { user.favorites.build }

  it 'creates .user_list based on user.id and list.id' do
    subject.user_list = nil
    subject.save
    expect(subject.user_list).to eq("#{user.id}_#{list.id}")
  end

  it "doesn't allow repeated favorites" do
    new_favorite.list = list
    expect(new_favorite.save).to eq(false)
  end

  it "doesn't permit sublist favorites" do
    new_favorite.list = sublist
    expect(new_favorite.save).to eq(false)
  end
end
