class BookmarksController < ApplicationController
  def index
    @bookmarks = Bookmark.order('created_at DESC')
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
      @bookmark.save!
      UrlInfoJob.perform_later(@bookmark)

      flash[:notice] = 'Bookmark was successfully created.'
      redirect_to bookmarks_path
    else
      render action: :new
    end
  end

  def new_batch
  end

  def create_batch
    url_list = params[:url_list]

    if url_list.blank?
      flash[:error] = "You didn't enter anything in the url list."
      redirect_to new_batch_bookmarks_path
      return
    end

    bookmarks, @invalid_bookmarks = Bookmark.create_from_list(url_list.split("\n"))

    if @invalid_bookmarks.present?
      render :new_batch
    else
      bookmarks.map(&:save!)
      flash[:notice] = "All the links have been added"
      redirect_to bookmarks_path
    end
  end

  def update_info
    @bookmark = Bookmark.find(params[:id])
    @bookmark.fetch_url_info
    @bookmark.save!

    flash[:notice] = 'Info updated'
    redirect_to :back
  end

  def destroy
    @bookmark = Bookmark.find(params[:id])
    @bookmark.destroy

    redirect_to action: :index
  end
end
