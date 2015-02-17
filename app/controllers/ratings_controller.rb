class RatingsController < ApplicationController
  def index
    @top_beers = Beer.top(3)
    @top_breweries = Brewery.top(3)
    @top_styles = Style.top(3)
    @top_users = User.top(3)
    @recent_ratings = Rating.recent
  end

  def new
    @rating = Rating.new
    @beers = Beer.all
  end

  def create
    @rating = Rating.create params.require(:rating).permit(:score, :beer_id)
    if current_user.nil?
      redirect_to signin_path, notice: "you should be signed in"
    elsif @rating.save
      current_user.ratings << @rating
      redirect_to user_path current_user
    else
      @beers = Beer.all
      render :new
    end
  end

  def destroy
    r = Rating.find(params[:id])
    r.delete if current_user == r.user
    redirect_to :back
  end
end