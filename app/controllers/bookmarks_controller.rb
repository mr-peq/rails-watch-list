class BookmarksController < ApplicationController
  def new
    @list = List.find(params[:id])
    @bookmark = Bookmark.new
  end

  def create
    search = params[:bookmark][:movie]
    url = "https://api.themoviedb.org/3/search/movie?query=#{search}&include_adult=false&language=en-US&page=1"
    response = URI.open(url, "Authorization" => 'Bearer eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiI1MTdhZGVhM2I1MWUzY2EyMmNhNDgzZTJhMWFiZmY0OCIsInN1YiI6IjY1NTc3YjNjYjU0MDAyMTRkMTE2ZDhlMiIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.3Hf3Hgn_N-UKn5ssH0g3db2DArQCQzBH-us1nIE6Lm4', "accept" => 'application/json').read
    data = JSON.parse(response)
    movie_title = data['results'].first['original_title']
    movie_overview = data['results'].first['overview']
    movie_poster_url = "https://image.tmdb.org/t/p/original/#{data['results'].first['poster_path']}"
    movie_rating = data['results'].first['vote_average'].to_f

    if Movie.exists?(title: movie_title)
      @movie = Movie.find_by(title: movie_title)
    else
      @movie = Movie.create(title: movie_title, overview: movie_overview, poster_url: movie_poster_url, rating: movie_rating)
    end

    @bookmark = Bookmark.new(bookmark_params)
    @list = List.find(params[:id])
    @bookmark.list = @list
    @bookmark.movie = @movie

    if @bookmark.save
      redirect_to list_path(@list)
    else
      # render :new, status: :unprocessable_entity
      redirect_to controller: :lists, action: :show, status: :unprocessable_entity
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
end
