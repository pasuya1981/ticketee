class TicketsController < ApplicationController

  before_action :require_signin! #, except: [:show, :index]
  before_action :set_project
  before_action :authorize_create, only: [:new, :create]
  before_action :set_ticket, only: [:show, :edit, :update, :destroy]

  def show
  	
  end

  def new
  	@ticket = @project.tickets.build
  end


  def create

    @ticket = @project.tickets.build(ticket_params)
    @ticket.user = current_user
    
    if @ticket.save
      flash[:notice] = 'Ticket has been created.'
      redirect_to [@project, @ticket] # eql to project_ticket_path(@project, @ticket)
    else
      flash.now[:alert] = 'Ticket has not been created.'
      render 'new'
    end
  end

  def edit
  end

  def destroy
    @ticket.destroy
    redirect_to @project, notice: "Ticket has been destroyed."
  end

  def update
  	if @ticket.update(ticket_params)
  	  flash[:notice] = "Ticket has been updated."
  	  redirect_to [@project, @ticket]
  	else
  	  flash.now[:alert] = "Ticket has not been updated."
  	  render 'edit'
  	end
  end

  private

    def authorize_create

      # if user is admin OR user has ability to create ticket
      # this before_action could pass!
      if !current_user.admin? && cannot?("create tickets".to_sym, @project)
        flash[:alert] = "You cannot create tickets on this project."
        redirect_to @project
      end
    end

    def set_project
      begin
        @project = Project.for(current_user).find(params[:project_id])
      rescue ActiveRecord::RecordNotFound
        redirect_to root_path, alert: "The project you were looking for could not be found."
      end
    end

    def set_ticket
      @ticket = @project.tickets.find(params[:id])
    end

    def ticket_params
      params.require(:ticket).permit(:title, :description)
    end
end
