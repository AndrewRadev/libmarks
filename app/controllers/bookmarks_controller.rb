class BookmarksController < ApplicationController
  def index
    @bookmarks = Bookmark.all
  end

  def show
    @bookmark = Bookmark.find(params[:id])
  end

  def new
    @bookmark = Bookmark.new
  end

  def create
    bookmark_params = params.require(:bookmark).permit(:url)
    @bookmark = Bookmark.new(bookmark_params)

    if @bookmark.valid?
      @bookmark.fetch_url_info
      @bookmark.save!

      flash[:notice] = 'Bookmark was successfully created.'
      redirect_to @bookmark
    else
      render action: :new
    end
  end

  def destroy
    @bookmark = Bookmark.find(params[:id])
    @bookmark.destroy

    redirect_to action: :index
  end
end
