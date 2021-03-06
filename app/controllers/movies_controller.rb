class MoviesController < ApplicationController

  def movie_params
    params.require(:movie).permit(:title, :rating, :description, :release_date)
  end

  def show
    id = params[:id] # retrieve movie ID from URI route
    @movie = Movie.find(id) # look up movie by unique ID
    # will render app/views/movies/show.<extension> by default
  end
  @issort=false
  @all_ratings=Array.new
  @ratings=Array.new
  
  def index
    if params[:rating]!=nil
      @ratings= Hash[params[:rating]].keys
         
    else
      @ratings=Movie.ratingcollection
    end
    @all_ratings=Movie.ratingcollection
    
    if params[:sort]=="titlesort"
      
      @movies = Movie.all.order(title: :asc)
      @issort="titlesort"
    elsif params[:sort]=="datesort"
      
      @movies = Movie.all.order(release_date: :asc)
      @issort="datesort"
    else
            
      @movies=Movie.where(rating: @ratings)
      @issort=false
    end
    
  end

  def new
    # default: render 'new' template
  end

  def create
    @movie = Movie.create!(movie_params)
    flash[:notice] = "#{@movie.title} was successfully created."
    redirect_to movies_path
  end

  def edit
    @movie = Movie.find params[:id]
  end

  def update
    @movie = Movie.find params[:id]
    @movie.update_attributes!(movie_params)
    flash[:notice] = "#{@movie.title} was successfully updated."
    redirect_to movie_path(@movie)
  end

  def destroy
    @movie = Movie.find(params[:id])
    @movie.destroy
    flash[:notice] = "Movie '#{@movie.title}' deleted."
    redirect_to movies_path
  end

  




end
