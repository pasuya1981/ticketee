require 'rails_helper'

feature 'Hidden links' do

  let(:user) { FactoryGirl.create(:user) }
  let(:admin) { FactoryGirl.create(:admin_user) }
  let(:project) { FactoryGirl.create(:project) }
  let(:ticket) { FactoryGirl.create(:ticket, project: project, user: user) }

  context "Anonymous users" do

  	scenario "cannot see the New Project link" do
  	  visit '/'
  	  expect(page).to_not have_css('a', text: 'New Project')
  	end

    scenario 'Cannot see the Edit Project link' do
      visit project_path(project)
      expect(page).to_not have_css('a', text: 'Edit Project')
    end

    scenario 'Cannot see the Delete Project link' do
      visit project_path(project)
      expect(page).to_not have_css('a', text: 'Delete Project')
    end
  end

  context "Regular users" do

  	before do
  	  sign_in(user)
  	end

    scenario "Delete ticket link is show to a user with permission" do
      ticket
      define_permission!(user, 'view', project)
      define_permission!(user, 'delete tickets', project)
      visit project_path(project)
      click_link ticket.title
      expect(page).to have_link('Delete Ticket')
    end

    scenario "Delete ticket link is hidden from users without permission" do
      ticket
      define_permission!(user, 'view', project)
      visit project_path(project)
      click_link ticket.title
      expect(page).to_not have_link 'Delete Ticket'
    end

    scenario "Edit ticket link is show to a user with permission" do
      ticket
      define_permission!(user, 'view', project)
      define_permission!(user, 'edit tickets', project)
      visit project_path(project)
      click_link ticket.title
      expect(page).to have_link('Edit Ticket')
    end

    scenario "New ticket link is show to a user with permission" do
      define_permission!(user, 'view', project)
      define_permission!(user, 'create tickets', project)
      visit project_path(project)
      expect(page).to have_link('New Ticket')
    end

    scenario "New ticket link is hidden from a user without permission" do
      define_permission!(user, :view, project)
      visit project_path(project)
      expect(page).to_not have_link('New Ticket')
    end

  	scenario 'Cannot see the New Project link' do
  	  visit '/'
  	  expect(page).to_not have_css('a', text: 'New Project')
      
  	end

    scenario 'Cannot see the Edit Project link' do
      visit project_path(project)
      expect(page).to_not have_css('a', text: 'Edit Project')
    end

    scenario 'Cannot see the Delete Project link' do
      visit project_path(project)
      expect(page).to_not have_css('a', text: 'Delete Project')
    end
  end

  context 'Admin users' do

  	before do
  	  sign_in(admin)
  	end

    scenario "Delete ticket link is show to admins" do
      ticket
      visit project_path(project)
      click_link ticket.title
      expect(page).to have_link('Delete Ticket')
    end

    scenario "Edit ticket link is shown to admins" do
      ticket
      visit project_path(project)
      click_link ticket.title
      expect(page).to have_link('Edit Ticket')
    end

    scenario "New ticket link is show to admins" do
      visit project_path(project)
      expect(page).to have_link("New Ticket")
    end

  	scenario 'Can see the New Project link' do
  	  visit '/'
  	  expect(find_link('New Project').visible?).to be(true)
  	end

    scenario 'Cannot see the Edit Project link' do
      visit project_path(project)
      expect(page).to have_css('a', text: 'Edit Project')
    end

    scenario 'Cannot see the Delete Project link' do
      visit project_path(project)
      expect(page).to have_css('a', text: 'Delete Project')
    end
  end

  def sign_in(user)
  	visit '/'
  	click_link 'Sign in'
  	fill_in 'Name', with: user.name
  	fill_in 'Password', with: user.password
  	click_button 'Sign in'
  end
end