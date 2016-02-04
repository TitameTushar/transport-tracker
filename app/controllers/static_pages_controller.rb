class StaticPagesController < ApplicationController
  def about
  end

  def contact
  end

  def home
  	if signed_in? 
   		redirect_to current_user
   	else
   	end

  end

  def help
  end
  
end
