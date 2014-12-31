class RatingsController < ApplicationController
  
  respond_to :html, :xml, :json
  before_action :set_rating, only: [:show, :edit, :update, :destroy]
  
  def getRating
    eid = params[:entity_id]
    @response = {}
    @rating = Rating.last_n_comments(eid) 
    
    if @rating == nil 
      raise RatingService::RatingNotFound
    else
      @response = {entityId: eid, calculatedRating: Rating.caculated_rating(eid), comments: Rating.last_n_comments(eid)} 
      puts "ahoj - 3"
      puts @response
      respond_with(@response) do |format|  
        format.xml { render :xml => @response }  
        format.html {}
      end  
    end 
  end
  
  # GET /ratings
  # GET /ratings.json
  def index
    @current_user ||= Owner.find_by_id(session[:user_id])    
    respond_to do |format|
      format.html {
        @ratings = Rating.order("updated_at DESC").page(params[:page]).per(15)
      }
      format.xml {
        @ratings = Rating.order("updated_at DESC")
      }
    end
    respond_with(@ratings)
  end

  # GET /ratings/1
  # GET /ratings/1.json
  def show
  end

  # GET /ratings/new
  def new
    @rating = Rating.new
  end

  # GET /ratings/1/edit
  def edit
  end

  # POST /ratings
  # POST /ratings.json
  def create
    new_params = {} # params for LocalID
    respond_to do |format|
      format.html { 
        @owner = Owner.find_by_id(session[:user_id]) 
        new_params = params        
        
      }
      format.xml {
        @owner = Owner.find(params[:owner])
        new_params = params
      }
    end 
    
    @rating = Rating.new(rating_params)

    respond_to do |format|
      if @rating.save
        format.html { redirect_to @rating, notice: 'Rating was successfully created.' }
        format.json { render :show, status: :created, location: @rating }
        format.xml {respond_with @rating}
      else
        format.html { render :new }
        format.json { render json: @rating.errors, status: :unprocessable_entity }
        format.json { render xml: @rating.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /ratings/1
  # PATCH/PUT /ratings/1.json
  def update
    respond_to do |format|
      if @rating.update(rating_params)
        format.html { redirect_to @rating, notice: 'Rating was successfully updated.' }
        format.json { render :show, status: :ok, location: @rating }
      else
        format.html { render :edit }
        format.json { render json: @rating.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /ratings/1
  # DELETE /ratings/1.json
  def destroy
    @rating.destroy
    respond_to do |format|
      format.html { redirect_to ratings_url, notice: 'Rating was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_rating
      @rating = Rating.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def rating_params
      puts "Ahoj - 2"
      puts params
      params.permit(:event_id, :username, :comment, :entity_id, :rating)
    end
end
