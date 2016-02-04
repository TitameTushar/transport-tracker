class RoutesController < ApplicationController
  def index
    @routes = Route.all
  end

  def show
  @route = Route.find(params[:id])
  @buses = Bus.all
  end
  
  def new
  	@route = Route.new
    @pos =Position.new
  end

  def edit
    @route = Route.find(params[:id])

  end

  def update
    @route = Route.find(params[:id])
     @halts= @route.halts
     @bus= @route.bus
     @pos = Position.where(:route => @route.route_name).first
     @count = 0
    if @route.update_attributes(params[:route].permit(:route_name, :source, :destination))
       @lat= Halt.where(:halt_name => @route.source).first.latitude
       @long= Halt.where(:halt_name => @route.source).first.longitude
       @halts.each do |halt|
         halt.update_attributes route: @route
         @count = @count + 1
       end
       if((@bus.update_attributes route: @route) && (@route.update_attributes s_lat: @lat, s_long: @long) && (@pos.update_attributes route: @route))
          flash[:success] = "Route, its #{@count} halts and bus updated successfully"
          redirect_to @route
       end
     else
      render 'edit'
     end
   end

  def create
     @route = Route.new(params[:route].permit(:route_name, :source, :destination))
     @pos = Position.new route: @route
     @lat= Halt.where(:halt_name => @route.source).first.latitude
     @long= Halt.where(:halt_name => @route.source).first.longitude
     if ((@route.save) && (@route.update_attributes s_lat: @lat, s_long: @long))
      @pos = Position.new route: @route.route_name
      if (@pos.save)
        @bus=@route.bus
        @halt = Halt.where(:halt_name => @route.source).first
        if ((@halt.update_attributes route: @route, bus: @bus) && (@halt.save))
       flash[:success] = "New Route added!...Add halts and bus for it"
       redirect_to @route
        end
      end
    else
      render 'new'
    end
  end

   def destroy
    Route.find(params[:id]).destroy
    flash[:success] = "Route deleted."
    redirect_to routes_url
  end
end
