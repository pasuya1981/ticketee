require 'rails_helper'

feature "Viewing projects" do

  let!(:user) { FactoryGirl.create(:user) }
  let!(:project) { FactoryGirl.create(:project) }

  context "When sign out" do

    before { sign_out! }
    scenario "cannot see projects" do
      visit projects_url
      expect(page).to_not have_link(project.name)
      flash_error = "You need to sign in or sign up before continuing."
      expect(page).to have_content(flash_error)
    end
  end

  context "When Sign in" do

    before do
      sign_in_as!(user)
      define_permission!(user, :view, project)
    end

    scenario "Listing all projects" do
      visit '/'
      click_link project.name
      expect(page.current_url).to eql(project_url(project))
    end
  end

  
end