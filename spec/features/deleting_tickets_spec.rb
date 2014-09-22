require 'rails_helper'

feature 'Deleting tickets' do

  let!(:project) { FactoryGirl.create(:project, name: 'project name') }
  let!(:user) { FactoryGirl.create(:user) }
  let!(:ticket) { FactoryGirl.create(:ticket, title: 'This Is A Ticket Title', project: project, user: user) }
  

  before do

  	sign_in_as!(user)
    define_permission!(user, :view, project)
    
  	click_link project.name
  	click_link ticket.title
  	click_link 'Delete Ticket'
  end

  scenario 'One ticket deletion' do
    expect(page).to have_content 'Ticket has been destroyed'
    expect(page.current_url).to eq(project_url(project))
  end
end