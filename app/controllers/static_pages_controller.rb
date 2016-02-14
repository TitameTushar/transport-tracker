class StaticPagesController < ApplicationController
  def about
  end

  def contact
  end

  def home 
   	redirect_to(current_user) if user_signed_in?
  end

  def help
  end
end
