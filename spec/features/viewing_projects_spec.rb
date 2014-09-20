require 'rails_helper'

feature "Viewing projects" do

  scenario "Listing all projects" do
  	project = FactoryGirl.create(:project, name: "TaxeMate 2")
  	visit '/'

  	click_link 'TaxeMate 2'
  	expect(page.current_url).to eql(project_url(project))
  end
end