class RatingsController < ApplicationController
  def index
    @ratings = Rails.cache.fetch('all ratings', expires_in:10.minutes){ Rating.all }
    @top_beers = Rails.cache.fetch('beer top 3', expires_in:10.minutes){ Beer.top(3) }
    @top_breweries = Rails.cache.fetch('brewery top 3', expires_in:10.minutes){ Brewery.top(3) }
    @top_styles = Rails.cache.fetch('style top 3',  expires_in:10.minutes){ Style.top(3) }
    @top_users = Rails.cache.fetch('user top 3', expires_in:10.minutes){ User.top(3) }
    @recent_ratings = Rails.cache.fetch('recent ratings', expires_in:10.minutes){ Rating.recent }
    @ratings_count = Rails.cache.fetch('ratings count', expires_in:10.minutes){ Rating.count }
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