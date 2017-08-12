class BusDetailsController < ApplicationController
  before_action :set_bus_detail, only: [:show, :edit, :update, :destroy]

  # GET /bus_details
  # GET /bus_details.json
  def index
    @bus_details = BusDetail.where(is_main: true).paginate(page: params[:page], per_page: 10)
  end

  # GET /bus_details/1
  # GET /bus_details/1.json
  def show
  end

  # GET /bus_details/new
  def new
    @bus_detail = BusDetail.new
  end

  # GET /bus_details/1/edit
  def edit
  end

  # POST /bus_details
  # POST /bus_details.json
  def create
    @bus_detail = BusDetail.new(bus_detail_params)

    respond_to do |format|
      if @bus_detail.save
        @bus_detail.get_geo_location

        if @bus_detail.is_return_route
          bd = BusDetail.create(name: @bus_detail.name, number: @bus_detail.number, source: @bus_detail.destination, destination: @bus_detail.source)
          @bus_detail.bus_routes.reverse.each_with_index do |br, index|
            bd.bus_routes.build(name: br.name)
            bd.save
          end
          bd.get_geo_location
        else
          bd = BusDetail.create(name: @bus_detail.name, number: @bus_detail.number, source: @bus_detail.destination, destination: @bus_detail.source)
          @bus_detail.bus_return_routes.each_with_index do |br, index|
            bd.bus_routes.build(name: br.name)
            bd.save
          end
          bd.get_geo_location
        end

        @bus_detail.bus_routes.each_with_index do |br, index|
          @bus_detail.update(is_main: true)
          # source to routes
          p "source to routes 111111111111111"
          bd = BusDetail.create(name: @bus_detail.name, number: @bus_detail.number, source: @bus_detail.source, destination: br.name)
          i = 0
          loop do
            bd.bus_routes.build(name: @bus_detail.bus_routes[i-1].name) unless i == 0
            bd.save
            break if br.name == @bus_detail.bus_routes[i].name
            i+=1
          end
          bd.get_geo_location
          bd = BusDetail.create(name: @bus_detail.name, number: @bus_detail.number, source: br.name, destination: @bus_detail.source)
          i = 0
          loop do
            bd.bus_routes.build(name: @bus_detail.bus_routes[i-1].name) unless i == 0
            bd.save
            break if br.name == @bus_detail.bus_routes[i].name
            i+=1
          end
          bd.get_geo_location
          # Destination to routes
          p "Destination to routes 11111111111111"
          if @bus_detail.is_return_route
            bd = BusDetail.create(name: @bus_detail.name, number: @bus_detail.number, source: @bus_detail.destination, destination: br.name)
            i = index
            loop do
              break if @bus_detail.bus_routes.last.name == @bus_detail.bus_routes[i].name
              bd.bus_routes.build(name: @bus_detail.bus_routes[i+1].name)
              bd.save
              i+=1
            end
            bd.get_geo_location

          end
          bd = BusDetail.create(name: @bus_detail.name, number: @bus_detail.number, source: br.name, destination: @bus_detail.destination)
          i = index
          loop do
            break if @bus_detail.bus_routes.last.name == @bus_detail.bus_routes[i].name
            bd.bus_routes.build(name: @bus_detail.bus_routes[i+1].name)
            bd.save
            i+=1
          end
          bd.get_geo_location
          # source route to route
          p "source route to route 1111111111111"
          i = index+1
          count = @bus_detail.bus_routes.count
          unless count == index+1
            loop do
              break if count == i
              bd = BusDetail.create(name: @bus_detail.name, number: @bus_detail.number, source: br.name, destination: @bus_detail.bus_routes[i].name)
              (index..i).each_with_index do |ib, ind|
                unless (ind == 0) || ((index..i).last == ind)
                  unless @bus_detail.bus_routes[i].name == @bus_detail.bus_routes[ib].name
                    bd.bus_routes.build(name: @bus_detail.bus_routes[ib].name)
                  end
                end
              end
              i+=1
              bd.get_geo_location
            end
          end
          # Destination route to route
          p "Destination route to route 1111111111111"
          if @bus_detail.is_return_route
            p "$$$$$$$$$$$$4"
            i = index
            count = @bus_detail.bus_routes.count
            unless count == index+1
              loop do
                bd = BusDetail.create(name: @bus_detail.name, number: @bus_detail.number, source: @bus_detail.bus_routes[count-1].name, destination: br.name)
                (i..count-1).each_with_index do |ib, ind|
                  unless (count-2) <= i
                    bd.bus_routes.build(name: @bus_detail.bus_routes[ib+1].name)
                    bd.save
                  end
                  i+=1
                end
                bd.get_geo_location
                break if count == i
              end
            end
          end
        end
        unless @bus_detail.is_return_route
          @bus_detail.bus_return_routes.each_with_index do |br, index|
            # Destination to route
            bd = BusDetail.create(name: @bus_detail.name, number: @bus_detail.number, source: @bus_detail.destination, destination: br.name)
            i = 0
            loop do
              break if br.name == @bus_detail.bus_return_routes[i].name
              bd.bus_return_routes.build(name: @bus_detail.bus_return_routes[i].name)
              bd.save
              i+=1
            end
            bd.get_geo_location
            i = index+1
            count = @bus_detail.bus_return_routes.count
            unless count == index+1
              loop do
                break if count == i
                bd = BusDetail.create(name: @bus_detail.name, number: @bus_detail.number, source: br.name, destination: @bus_detail.bus_return_routes[i].name)
                (index..i).each_with_index do |ib, ind|
                  unless (ind == 0) || ((index..i).last == ind)
                    unless @bus_detail.bus_return_routes[i].name == @bus_detail.bus_return_routes[ib].name
                      bd.bus_return_routes.build(name: @bus_detail.bus_return_routes[ib].name)
                    end
                  end
                end
                i+=1
                bd.get_geo_location
              end
            end
          end
        end
        format.html { redirect_to bus_details_path, notice: 'Bus detail was successfully created.' }
        format.json { render :show, status: :created, location: @bus_detail }
      else
        format.html { render :new }
        format.json { render json: @bus_detail.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /bus_details/1
  # PATCH/PUT /bus_details/1.json
  def update
    respond_to do |format|
      if @bus_detail.update(bus_detail_params)
        @bus_detail.get_geo_location
        format.html { redirect_to bus_details_path, notice: 'Bus detail was successfully updated.' }
        format.json { render :show, status: :ok, location: @bus_detail }
      else
        format.html { render :edit }
        format.json { render json: @bus_detail.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /bus_details/1
  # DELETE /bus_details/1.json
  def destroy
    @bus_detail.destroy
    respond_to do |format|
      format.html { redirect_to bus_details_url, notice: 'Bus detail was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def search_buses
    @source = params[:source]
    @desti = params[:destination]
    p @buses = BusDetail.get_buses(@source, @desti)
    respond_to do |format|
      format.js
      format.html
    end
  end

  def change_bus
    @bus_list = BusDetail.find(params[:bus_id])
    p @bus_list.bus_routes
  end

  def delete_selected_bus
    @bus_ids = params[:bus_ids]
    @bus_lists = BusDetail.where(id: @bus_ids)
    @bus_lists.destroy_all
    redirect_back(fallback_location: root_path)
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_bus_detail
      @bus_detail = BusDetail.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def bus_detail_params
      params.require(:bus_detail).permit(:name, :number, :source, :destination, :source_lat, :destination_lat, :source_lang, :destination_lang, :is_return_route, bus_routes_attributes: [:id, :name, :source_distance, :destination_distance, :_destroy], bus_return_routes_attributes: [:id, :name, :source_distance, :destination_distance, :_destroy])
    end
end
