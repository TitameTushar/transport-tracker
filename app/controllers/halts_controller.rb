class HaltsController < ApplicationController

  def new
    if !(params[:route_id].nil?)
   @route = Route.find(params[:route_id])
    else
   @halt= Halt.new
   end
  end

  def index
   if !(params[:route_id].nil?)
    @route= Route.find(params[:route_id])
    @halts = Halt.all
   else
    @halts = Halt.all
   end
  end

  def create
    if !(params[:route_id].nil?)
    @route = Route.find(params[:route_id])
    @bus = @route.bus
    @halt = @route.halts.create(params[:halt].permit(:halt_name, :bus_arrivetime, :bus_departtime, :title, :description).merge(:bus_id => @bus.id))
    redirect_to route_halt_path(@route,@halt)
    else
    @halt = Halt.create(params[:halt].permit(:halt_name, :bus_arrivetime, :bus_departtime, :title, :description))
    redirect_to halt_path(@halt)
    end  
  end

  def edit
    @halt = Halt.find(params[:id])
  end
 
  def update
    @halt = Halt.find(params[:id])
    if @halt.update_attributes(params[:halt].permit(:halt_name, :bus_arrivetime, :bus_departtime, :title, :description))
      flash[:success] = "Halt and its attibutes updated successfully"
      redirect_to halts_path
    else
      render 'edit'
    end
  end

  def destroy
    if params[:route_id].nil?  
      @halt = Halt.find(params[:id])
    else
      @route = Route.find(params[:route_id])
      @halt = @route.halts.find(params[:id])
    end
    if (@halt.destroy)
     flash[:success] = "Successfully deleted Halt"
     if !(params[:route_id].nil?)  
       redirect_to route_path(@route)
     else
       redirect_to halts_path
     end
   end
  end
  
  def show
  @halt = Halt.find(params[:id])
   if !(params[:route_id].nil?) 
   @route = Route.find(params[:route_id])
   @bus =@route.bus
   end
  end

   def display
    @r = Route.find(params[:route_id])
  end
   
   def remove
     @route = Route.find(params[:route_id])
    @halt = Halt.find(params[:id])
    @users = @halt.users
    if ((@halt.update_attributes :route_id => "NULL") && (@halt.save))
      @users.each do |user|
      if ((user.update_attributes :halt_id => "NULL") && (user.save))
      else
        redirect_to display_route_halts_path(@route)
      end
      end
       flash[:success] = "Successfully Removed Halt"
      redirect_to display_route_halts_path(@route)
    else
       redirect_to display_route_halts_path(@route)
    end
   end

  def register  
    @route = Route.find(params[:route_id])
    @halt = Halt.find(params[:id])
    @bus = @halt.bus
   if (@bus.bus_capacity > 0)
    if !(current_user.bus.nil?)
      @prev = current_user.bus
      @capacity = @prev.bus_capacity + 1

     if @prev.update_attributes bus_capacity: @capacity
      if ((current_user.update_attributes route: @route, halt: @halt, bus: @bus) && (current_user.save))
      @capacity= @bus.bus_capacity - 1
      if @bus.update_attributes bus_capacity: @capacity
      flash[:success] = "Successfully Registered for this Halt"
      redirect_to user_path(current_user)
      else
        redirect_to user_path(current_user)
      end
      else 
      redirect_to user_path(current_user)
      end
      else 
      redirect_to user_path(current_user)
      end
    else
      if ((current_user.update_attributes route: @route, halt: @halt, bus: @bus) && (current_user.save))
      @capacity= @bus.bus_capacity - 1
      if @bus.update_attributes bus_capacity: @capacity
      flash[:success] = "Successfully Registered for this Halt"
      redirect_to user_path(current_user)
      else 
      redirect_to user_path(current_user)
      end
      else 
      redirect_to user_path(current_user)
      end
    end
  else 
     Rails.logger.info(current_user.errors.messages.inspect)
     redirect_to user_path(current_user)
  end
 end

  def assign_halt
    @route= Route.find(params[:route_id])
    @halt= Halt.find(params[:id])
    @bus= @route.bus
    if ((@halt.update_attributes route: @route, bus: @bus) && (@halt.save))
       flash[:success] = "Successfully Assigned Halt To Route"
     end
    redirect_to route_halts_path(@route)
  end
end