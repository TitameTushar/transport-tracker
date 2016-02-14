class VehiclesController < ApplicationController
	#before_action :admin_user,     only:  [:create, :edit, :destroy]
  
  def index
    @vehicles = Vehicle.all
    @vehicle = Vehicle.new
  end

  def show
    @vehicle = Vehicle.find(params[:id])
    @route = Route.find(params[:route_id]) if params[:route_id]
  end

  def new
    @vehicle= Vehicle.new
    @route= Route.find(params[:route_id])
  end
 
  def edit
    @vehicle = Vehicle.find(params[:id])
  end
  
  def create
    if (params[:route_id].nil?)
      @vehicle = Vehicle.new(vehicle_params)
      if @vehicle.save
        flash[:success] = "New Bus Added"
        redirect_to bus_path(@vehicle)
      end
    else
      @route = Route.find(params[:route_id])
      @vehicle = @route.create_bus(vehicle_params)
      flash[:success] = "New Bus Added To Route"
      redirect_to route_bus_path(@route,@vehicle)
    end
  end
 
  def update
    @vehicle = Vehicle.find(params[:id])
    #how to find previously alloted bus for this route
    if @vehicle.update_attributes(vehicle_params)
      flash[:success] = "Bus name and its bus updated successfully"
      redirect_to vehicles_path
    else
      render 'edit'
    end
  end
  
  def destroy
    @vehicle = Vehicle.find(params[:id])
    @vehicle.halts
    @vehicle.destroy
    redirect_to vehicles_path
  end

  def assign
    @route = Route.find(params[:route_id])
    @vehicle = Vehicle.find(params[:bus_id])
    @prev= @route.bus
    if !(@prev.nil?)
      @prev.update_attributes route_id: "NULL"
    end
    if((@vehicle.update_attributes route: @route))
      flash[:success] = "New bus assigned successfully"
      redirect_to routes_path
    else
      redirect_to routes_path
    end
  end

  private

  def vehicle_params
    params[:vehicle].permit(:registration_number, :capacity)
  end
end