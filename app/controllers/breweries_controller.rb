class BreweriesController < ApplicationController
  before_action :set_brewery, only: [:show, :edit, :update, :destroy]
  before_action :ensure_that_signed_in, except: [:index, :show, :list]
  before_action :ensure_that_admin, only: [:destroy]
  
  before_action :skip_if_cached, only: [:index]  
  
  def skip_if_cached
    @order = params[:order] || 'name'
    return render :index if (fragment_exist?( "activebrewerylist-#{@order}" ) and fragment_exist?( "retiredbrewerylist-#{@order}" ) )
  end  
  
  # GET /breweries
  # GET /breweries.json
  def index
  	 @breweries = Brewery.all
    @active_breweries = Brewery.active
    @retired_breweries = Brewery.retired
    #order = params[:order] || 'name'
    
    sort_breweries(@order)
  end

  # GET /breweries/1
  # GET /breweries/1.json
  def show
 	 
  end

  def list
  end

  # GET /breweries/new
  def new
    @brewery = Brewery.new
  end

  # GET /breweries/1/edit
  def edit
  end

  # POST /breweries
  # POST /breweries.json
  def create
    expire_all_fragments
    @brewery = Brewery.new(brewery_params)

    respond_to do |format|
      if @brewery.save
        format.html { redirect_to @brewery, notice: 'Brewery was successfully created.' }
        format.json { render :show, status: :created, location: @brewery }
      else
        format.html { render :new }
        format.json { render json: @brewery.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /breweries/1
  # PATCH/PUT /breweries/1.json
  def update
    expire_all_fragments
    respond_to do |format|
      if @brewery.update(brewery_params)
        format.html { redirect_to @brewery, notice: 'Brewery was successfully updated.' }
        format.json { render :show, status: :ok, location: @brewery }
      else
        format.html { render :edit }
        format.json { render json: @brewery.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /breweries/1
  # DELETE /breweries/1.json
  def destroy
    expire_all_fragments
    @brewery.destroy
    respond_to do |format|
      format.html { redirect_to breweries_url, notice: 'Brewery was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_brewery
      @brewery = Brewery.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def brewery_params
      params.require(:brewery).permit(:name, :year, :active)
    end
    
    def sort_breweries(order)
    	#direction = session[:last_dir]
      #session[:last_dir] = case session[:last_dir]
      #  when nil then 'asc'
      #  when 'asc' then 'desc'
      #  when 'desc' then 'asc'
      #end 
   	
      @active_breweries = case order
        when 'name' then @active_breweries.sort_by{ |b| b.name }
        when 'year' then @active_breweries.sort_by{ |b| b.year }
      end
    
      @retired_breweries = case order
        when 'name' then @retired_breweries.sort_by{ |b| b.name }
        when 'year' then @retired_breweries.sort_by{ |b| b.year }
      end
      
      #if direction == 'desc'
      #  @active_breweries = @active_breweries.reverse!
      #  @retired_breweries =  @retired_breweries.reverse!
      #end
    end
    
    def expire_all_fragments
      ["activebrewerylist-name", "activebrewerylist-year", "retiredbrewerylist-name", "retiredbrewerylist-year"].each{ |f| expire_fragment(f) }
    end
end
