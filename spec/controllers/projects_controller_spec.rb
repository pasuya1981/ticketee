require 'rails_helper'

RSpec.describe ProjectsController, :type => :controller do

  let(:user) { FactoryGirl.create(:user) }

  describe 'Standard users' do

    before do
      sign_in(user)
    end

    it "display an error message for an missing project" do
      get :show, id: 'no this id'

      expect(response).to redirect_to(projects_url)
      message = "The project you were looking for could not be found."
      expect(flash[:alert]).to eq(message)
    end

    context "Standard user" do

      { :new => :get, 
        :create => :post, 
        :edit => :get, 
        :update => :put, 
        :destroy => :delete }.each do |action, method|  

        it "can not access the #{action} action" do
          sign_in(user)
          send(method, action, :id => FactoryGirl.create(:project))
          expect(response).to redirect_to(root_path)
          expect(flash[:alert]).to eq("You must be an admin to do that.")
        end  
      end

      it "cannot access the show action without permission" do
        project = FactoryGirl.create(:project)
        get :show, id: project.id  
        expect(response).to redirect_to(projects_path)
        expect(flash[:alert]).to eq("The project you were looking for could not be found.")
      end
    end
  end
end
