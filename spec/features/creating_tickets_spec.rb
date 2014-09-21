require 'rails_helper'

feature "Creating Tickets" do
  
  before do
    FactoryGirl.create(:project, name: "Internet Explorer")
    visit '/'
    click_link "Internet Explorer"
    click_link "New Ticket"
  end

  scenario "Creating a ticket" do
    fill_in "Title", with: "Non-standard compliance"
    fill_in "Description", with: "My page is ugly"
    click_button "Create Ticket"

    expect(page).to have_content("Ticket has been created.")
  end

  scenario "Creating a ticket withou valid attributes" do
  	click_button 'Create Ticket'
  	expect(page).to have_content("Ticket has not been created.")
  	expect(page).to have_content("Title can't be blank")
  	expect(page).to have_content("Description can't be blank")
  end

  scenario "Description must be longer than 10 characters" do
  	fill_in 'Title', with: 'Non-standard compliance'
  	fill_in 'Description', with: 'it sucks'
  	click_button 'Create Ticket'

  	expect(page).to have_content('Ticket has not been created')
  	expect(page).to have_content('Description is too short')
  end
end