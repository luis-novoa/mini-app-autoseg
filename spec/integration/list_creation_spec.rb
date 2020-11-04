require 'rails_helper'

RSpec.describe 'lists/new.html.erb', type: :feature do
  let(:user) { create(:user) }
  before(:each) do
    login(user)
    visit new_list_path
    fill_in 'list_description', with: 'This is the list'
    fill_in 'list_sublists_attributes_0_description',	with: 'This is a sublist'
  end

  it 'can create a simple list' do
    click_on 'Submit'
    expect(List.first.sublists[0].description).to eq('This is a sublist')
  end

  context 'with JS added subtasks', js: true do
    it 'creates sibling subtasks' do
      2.times { click_on 'Add Another Task' }
      fill_in 'list_sublists_attributes_1_description',	with: 'This is a sublist'
      fill_in 'list_sublists_attributes_2_description',	with: 'This is a sublist'
      click_on 'Submit'
      sleep(1)
      expect(List.first.sublists.count).to eq(3)
    end

    it 'creates subtasks within subtasks' do
      click_on 'Add Subtask'
      within('#list_sublists_attributes_0') { click_on 'Add Subtask' }
      fill_in 'list_sublists_attributes_0_sublists_attributes_0_description',	with: 'This is a subsublist'
      fill_in(
        'list_sublists_attributes_0_sublists_attributes_0_sublists_attributes_0_description',
        with: 'Nesting on nested form works!'
      )
      click_on 'Submit'
      sleep(1)
      expect(List.first.sublists[0].sublists[0].sublists[0].description).to eq('Nesting on nested form works!')
    end
  end
end
