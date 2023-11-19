class BookmarksController < ApplicationController
  def new
    @list = List.find(params[:id])
    @bookmark = Bookmark.new
  end

  def create
    data = fetch_movie_data
    @list = List.find(params[:id])
    if data['results'].empty?
      flash[:notice] = 'Sorry, but something went wrong with your search.'
      redirect_to list_path(@list)
      return
    end
    movie = get_movie_data(data)

    if Movie.exists?(title: movie[:title])
      @movie = Movie.find_by(title: movie[:title])
    else
      @movie = Movie.create(movie)
    end

    @bookmark = Bookmark.new(bookmark_params)
    @list = List.find(params[:id])
    @bookmark.list = @list
    @bookmark.movie = @movie

    if @bookmark.valid?
      @bookmark.save
      flash[:notice] = ''
      redirect_to list_path(@list)
    else
      flash[:notice] = 'Your comment must be 6 characters minimum.'
      render 'lists/show', status: :unprocessable_entity
    end
  end

  def destroy
    @bookmark = Bookmark.find(params[:id])
    @list = @bookmark.list
    @bookmark.destroy
    redirect_to list_path(@list)
  end

  private

  def bookmark_params
    params.require(:bookmark).permit(:comment)
  end

  def fetch_movie_data
    encoded_search = CGI.escape(params[:bookmark][:movie])
    search = URI.parse(encoded_search).to_s
    url = "https://api.themoviedb.org/3/search/movie?query=#{search}&include_adult=false&language=en-US&page=1"
    options = { 'Authorization' => "Bearer #{ENV['TMDB_ACCESS_TOKEN']}", 'accept' => 'application/json' }

    response = URI.open(url, options).read
    JSON.parse(response)
  end

  def get_movie_data(data)
    title = data['results'].first['title']
    overview = data['results'].first['overview']
    poster_url = "https://image.tmdb.org/t/p/original/#{data['results'].first['poster_path']}"
    rating = data['results'].first['vote_average'].to_f.round(1)
    { title: title, overview: overview, poster_url: poster_url, rating: rating }
  end
end
