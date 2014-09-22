require 'rails_helper'

feature 'Viewing tickets' do

  let!(:user) { FactoryGirl.create(:user) }

  # 1st project-ticket pair
  let!(:project_1) { FactoryGirl.create(:project, name: 'TextMate 2') }
  let!(:project_1_ticket) { FactoryGirl.create(:ticket, project: project_1,
                                              user: user,
                                              title: 'Make it shiny!', 
                                              description: "Grandients! Starbursts! oh my!") }
  # 2nd project-ticket pair
  let!(:project_2) { FactoryGirl.create(:project, name: 'Internet Explorer') }
  let!(:project_2_ticket) { FactoryGirl.create(:ticket, project: project_2, 
                                                title: 'Standars compliance', 
                                                description: "Isn't a joke") }
  
  
  before do
    visit project_url(project_1)
    expect(page).to_not have_content(project_1_ticket.title)
    sign_in_as!(user)
    Project.all.each { |pro| define_permission!(user, :view, pro) }
    visit '/'
  end

  scenario "Viewing tickets for a given project" do

    click_link project_1.name
    expect(page).to have_content(project_1_ticket.title)
    expect(page).to_not have_content(project_2_ticket.title)

    click_link project_1_ticket.title
    within("#ticket h2") do
      expect(page).to have_content('Make it shiny!')
    end

    expect(page).to have_content("Grandients! Starbursts! oh my!")
  end

end