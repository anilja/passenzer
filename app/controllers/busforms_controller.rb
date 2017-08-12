    class BusformsController < ApplicationController
  before_action :set_busform, only: [:show, :edit, :update, :destroy]

  # GET /busforms
  # GET /busforms.json
  def index
    @search = Busform.search(params[:q])
    @busforms = @search.result
  #store all the clients that match the name searched    
  end
  

  # GET /busforms/1
  # GET /busforms/1.json
  def show
  end

  # GET /busforms/new
  def new
    @busform = Busform.new
  end

  # GET /busforms/1/edit
  def edit
  end

  # POST /busforms
  # POST /busforms.json
  def create
    @busform = Busform.new(busform_params)

    respond_to do |format|
      if @busform.save
        format.html { redirect_to @busform, notice: 'Busform was successfully created.' }
        format.json { render :show, status: :created, location: @busform }
      else
        format.html { render :new }
        format.json { render json: @busform.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /busforms/1
  # PATCH/PUT /busforms/1.json
  def update
    respond_to do |format|
      if @busform.update(busform_params)
        format.html { redirect_to @busform, notice: 'Busform was successfully updated.' }
        format.json { render :show, status: :ok, location: @busform }
      else
        format.html { render :edit }
        format.json { render json: @busform.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /busforms/1
  # DELETE /busforms/1.json
  def destroy
    @busform.destroy
    respond_to do |format|
      format.html { redirect_to busforms_url, notice: 'Busform was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_busform
      @busform = Busform.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def busform_params
      params.require(:busform).permit(:title, :description)
    end
end
