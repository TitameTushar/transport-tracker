class PositionsController < ApplicationController
 def new
 end

 def create
 end

 def show
 	@pos= Position.find(params[:id])
  if !(params[:user_id].nil?)
  @user= User.find(params[:user_id])
  else
  @user=current_user
  end
 	@current_halt= Halt.where(:halt_name => @pos.current_pos).first
 	@route= @user.route
 	#@cur_lat= @current_halt.latitude
 	#@cur_long= @current_halt.longitude
 	@location = Gmaps4rails.build_markers(@current_halt) do |loc, marker|
      marker.lat loc.latitude
      marker.lng loc.longitude
      marker.infowindow loc.description
    end
 end

 def edit
	@pos = Position.find(params[:id])
	@route= current_user.route
	@halts = @route.halts

 end

 def update
	@pos = Position.find(params[:id])
  if @pos.update_attributes (params[:position].permit(:current_pos, :alert))
       @name = @pos.current_pos
       @halt = Halt.where(:halt_name => @name).first
       @string = @halt.description
       @cur_desc= "#{@pos.current_pos} at #{Time.now.strftime("%I:%M%p")}"
       if @halt.update_attributes description: @cur_desc
       # Handle a successful update.
       @users = User.all
       @users.each do |user|
        if !(user.route.nil?)
        if (user.route.route_name  == @pos.route )
       AdminMailer.notify_email(user,@pos,current_user).deliver
        end
        end
       end
       flash[:success] = "Position Successfully Broadcasted On Map!"
       redirect_to @pos
       end
    else
      render 'edit'
    end
 end

 def destroy
 end

end
