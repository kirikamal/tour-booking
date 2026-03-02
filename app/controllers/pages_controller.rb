class PagesController < ApplicationController
  def about
  end

  def contact
  end

  def contact_submit
    name    = params[:name]
    email   = params[:email]
    message = params[:message]

    if name.blank? || email.blank? || message.blank?
      flash[:alert] = "Please fill in all required fields."
    else
      flash[:notice] = "Thanks #{name}! We'll reply to #{email} within 24 hours."
    end

    redirect_to contact_path
  end
end
