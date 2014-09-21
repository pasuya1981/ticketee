module ApplicationHelper

  def admin_user?
  	user = User.find_by(session[:user_id])
  	if user && user.admin
  	  return true
  	else
  	  return false
  	end
  end

  def admin_only &block
  	block.call if current_user.try(:admin)
  end

  def current_user
    User.find_by(id: session[:user_id])
  end

  def title(*parts)
    unless parts.empty?
      content_for :title do
        (parts << "Ticketee").join(" - ")
      end
    end
  end
end
