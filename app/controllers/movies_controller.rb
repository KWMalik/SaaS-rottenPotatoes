class MoviesController < ApplicationController

  def show
    id = params[:id] # retrieve movie ID from URI route
    @movie = Movie.find(id) # look up movie by unique ID
    # will render app/views/movies/show.<extension> by default
  end

  def index
    
    @all_ratings = Movie.ratings
    
    session[:sort_by] ||= 'title'
    session[:order] ||= 'DESC'
    session[:ratings] ||= @all_ratings
    
    filters = ['sort_by','order','ratings']
      
    session[:sort_by] = (params[:sort_by].blank? ? session[:sort_by] : params[:sort_by])
    session[:order] = (params[:order].blank? ? session[:order] : params[:order])
    session[:ratings] = (params[:ratings].blank? ? session[:ratings] : params[:ratings].keys)
    
    params.delete_if { |w| w =~ /controller|action$/ }
    
    redirect_to movies_path if !(params.keys & filters).empty?

    @movies = Movie.where(:rating => session[:ratings]).order("#{session[:sort_by]} #{session[:order]}")
    
  end

  def new
    # default: render 'new' template
  end

  def create
    @movie = Movie.create!(params[:movie])
    flash[:notice] = "#{@movie.title} was successfully created."
    redirect_to movies_path
  end

  def edit
    @movie = Movie.find params[:id]
  end

  def update
    @movie = Movie.find params[:id]
    @movie.update_attributes!(params[:movie])
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
