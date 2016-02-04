class UsersController < ApplicationController
  before_action :signed_in_user, only: [:index, :edit, :update, :destroy]
  before_action :correct_user,   only: [:edit, :update]
  before_action :admin_user,     only: :destroy
  
  def index
    @users = User.paginate(page: params[:page])
  end

  def show
  @user = User.find(params[:id])
   if !(@user.route.nil?)
     @halt= @user.halt
     @route= @user.route
     @hash = Gmaps4rails.build_markers(@halt) do |halt, marker|
      marker.lat halt.latitude
      marker.lng halt.longitude
      marker.infowindow halt.description
     end
     @pos = Position.where(:route => @route.route_name).first
     if @pos.nil?
      @pos= Position.new
      if @pos.update_attributes route: @route.route_name, current_pos: @route.source
        flash[:success] = "Bus at source"
         @pos = Position.where(:route => @route.route_name).first
      end
    end
   end
  end

  def drivers
    @bus= Bus.find(params[:bus_id])
    @drivers = User.where(:job_type => "Driver")
  end


  def alert
    if (current_user.job_type == "admin")
    @routes= Position.select("route, alert")
    else
    @route= Position.where(:route => current_user.route.route_name).first
    end
  end

  def new
  	@user = User.new
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update_attributes(user_params)
      # Handle a successful update.
      flash[:success] = "Profile updated"
      redirect_to @user
    else
      render 'edit'
    end
  end

  def create
     @user = User.new(user_params)
    if @user.save
      # Handle a successful save.
      AdminMailer.welcome_email(@user).deliver
      sign_in @user
      flash[:success] = "Welcome to the Bus Scheduler...!"
      redirect_to @user
    else
      render 'new'
    end
  end

   def destroy
    User.find(params[:id]).destroy
    flash[:success] = "User deleted."
    redirect_to users_url
  end

  def menu
     @user = User.find(params[:id])
  end
  
  def assign_driver
    @bus= Bus.find(params[:bus_id])
    @user= User.find(params[:user_id])
    @route= @bus.route
    @source= Halt.where(:halt_name => @route.source).first
    if ((@user.update_attributes bus: @bus, route: @route, halt: @source) && (@bus.update_attributes bus_driver: @user.username))
      flash[:success] = "Driver Assigned To Bus"
      redirect_to buses_path
    end
  end

  private

    def user_params
      params.require(:user).permit(:username, :email, :job_type, :address, :bus_id, :avatar, :password,
                                   :password_confirmation)
    end
  
    def signed_in_user
      unless signed_in?
        store_location
        redirect_to signin_url, notice: "Please sign in."
    end
  end

    def correct_user
      @user = User.find(params[:id])
      redirect_to(root_url) unless current_user?(@user)
    end
    def admin_user
      redirect_to(root_url) unless current_user.job_type =="admin"
    end
end
