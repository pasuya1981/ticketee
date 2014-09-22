require 'rails_helper'

feature "Creating Tickets" do

  let!(:user) { FactoryGirl.create(:user) }
  let!(:project) { FactoryGirl.create(:project, name: "Internet Explorer") }
  
  before do

    visit '/'
    click_link project.name

    message = "You need to sign in or sign up before continuing."
    expect(page).to have_content(message)

    sign_in_as! user
    define_permission!(user, :view, project)
    
    click_link project.name
    click_link 'New Ticket'
  end

  scenario "Creating a ticket" do
    fill_in "Title", with: "Non-standard compliance"
    fill_in "Description", with: "My page is ugly"
    click_button "Create Ticket"

    expect(page).to have_content("Ticket has been created.")

    within('#ticket #author') do
      expect(page).to have_content("Created by #{user.email}")
    end
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