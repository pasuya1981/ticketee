require 'rails_helper'

feature "Editing tickets" do
  let!(:project) { FactoryGirl.create(:project) }
  let!(:user) { FactoryGirl.create(:user) }
  let!(:ticket) do
    ticket = FactoryGirl.create(:ticket, project: project)
    ticket.update(:user => user)
    ticket
  end
  

  before do
    visit '/'

    click_link 'Sign in'
    fill_in 'Name', with: user.name
    fill_in 'Password', with: user.password
    click_button 'Sign in'

    click_link project.name
    click_link ticket.title
    click_link 'Edit Ticket'
  end

  scenario "Updating a ticket" do

  	fill_in 'Title', with: 'Make it really shiny!'
  	click_button 'Update Ticket'

  	expect(page).to have_content "Ticket has been updated."
    within("#ticket h2") do
      expect(page).to have_content ticket.reload.title
    end
  end

  scenario "Updating a ticket with invalid information" do
  	
    fill_in "Title", with: ""
    click_button "Update Ticket"
    expect(page).to have_content("Ticket has not been updated.")
  end
end