class UsersController < ApplicationController
  before_action :authenticate_user!, only: [:index, :edit, :update, :destroy]
  before_action :admin_user,     only: :destroy
  
  def index
    @users = User.paginate(page: params[:page])
  end

  def show
    @user = User.where(id: params[:id]).first
    if @user_halt = @user.route_halt
      @route= @user_halt.route
      @hash = Gmaps4rails.build_markers(@user_halt.halt) do |halt, marker|
        marker.lat halt.latitude
        marker.lng halt.longitude
        marker.infowindow halt.description
      end
      @source = @route.route_halts.source
      @destination = @route.route_halts.destination
      @vehicle = @route.vehicle
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
      redirect_to(root_url) unless current_user.role == 'admin'
    end
end
