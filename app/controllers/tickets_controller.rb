class TicketsController < ApplicationController

  before_action :require_signin!, except: [:show, :index]
  before_action :set_project
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

    def require_signin!

      if current_user.nil?

        flash[:error] = "You need to sign in or sign up before continuing."
        redirect_to signin_url
      end
    end

    def current_user
      @current_user ||= User.find(session[:user_id]) if session[:user_id]
    end

    def set_project
      @project = Project.find(params[:project_id])
    end

    def set_ticket
      @ticket = @project.tickets.find(params[:id])
    end

    def ticket_params
      params.require(:ticket).permit(:title, :description)
    end
end
