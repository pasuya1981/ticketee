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

    sign_in_as!(user)
    define_permission!(user, :view, project)
    define_permission!(user, 'edit tickets', project)

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