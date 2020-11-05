require 'rails_helper'

RSpec.describe 'lists/edit.html.erb', type: :feature do
  let(:user) { create(:user) }
  let!(:list) { create(:list, user: user, sublist_max_level: 2) }
  let!(:sublist1) { create(:sublist, parent_list: list) }
  let!(:sublist2) { create(:sublist, parent_list: sublist1) }

  before(:each) do
    login(user)
    visit edit_list_path(list)
  end

  it 'updates sublist' do
    fill_in 'list_sublists_attributes_0_description',	with: 'This sublist was updated!'
    click_on 'Submit'
    expect(sublist1.reload.description).to eq('This sublist was updated!')
  end
end
