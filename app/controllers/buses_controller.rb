class BusesController < ApplicationController
	#before_action :admin_user,     only:  [:create, :edit, :destroy]
  
  def index
    @buses = Bus.all
    @bus= Bus.new
  end

  def show
     @bus = Bus.find(params[:id])
  if !(params[:route_id].nil?)
  @route = Route.find(params[:route_id])
  end
  end

 def new
  @bus= Bus.new
  @route= Route.find(params[:route_id])
 end
 
  def edit
    @bus = Bus.find(params[:id])
  end
  
  def create
    if (params[:route_id].nil?)
    @bus = Bus.new(params[:bus].permit(:bus_no, :bus_capacity))
    if @bus.save
      flash[:success] = "New Bus Added"
     redirect_to bus_path(@bus)
   end
  else
    @route = Route.find(params[:route_id])
    @bus = @route.create_bus(params[:bus].permit(:bus_capacity, :bus_no))
    flash[:success] = "New Bus Added To Route"
    redirect_to route_bus_path(@route,@bus)
  end
  end
 
  def update
    @bus = Bus.find(params[:id])
    #how to find previously alloted bus for this route
    if @bus.update_attributes(params[:bus].permit(:bus_capacity,:bus_no))
      flash[:success] = "Bus name and its bus updated successfully"
      redirect_to buses_path
    else
      render 'edit'
    end
  end
  
  def destroy
    @bus = Bus.find(params[:id])
    @bus.halts
    @bus.destroy
    redirect_to buses_path
  end

 def assign
    @route = Route.find(params[:route_id])
    @bus = Bus.find(params[:bus_id])
    @prev= @route.bus
   if !(@prev.nil?)
     @prev.update_attributes route_id: "NULL"
   end
       if ((@bus.update_attributes route: @route))
         flash[:success] = "New bus assigned successfully"
         redirect_to routes_path
         else
         redirect_to routes_path
        end
  end
end