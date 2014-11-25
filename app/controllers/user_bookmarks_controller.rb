class UserBookmarksController < ApplicationController
  def index
    @bookmarks = UserBookmark.order('created_at DESC').includes(:tags)
  end

  def show
    @bookmark = UserBookmark.find(params[:id])
  end

  def new
    @bookmark = UserBookmark.new
  end

  def create
    bookmark_params = params.require(:user_bookmark).permit(:url, :tag_list)
    @bookmark = UserBookmark.new(bookmark_params)

    if @bookmark.valid?
      @bookmark.save!
      UrlInfoJob.perform_later(@bookmark)

      flash[:notice] = 'Bookmark was successfully created.'
      redirect_to user_bookmarks_path
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
      redirect_to new_batch_user_bookmarks_path
      return
    end

    bookmarks, @invalid_bookmarks = UserBookmark.create_from_list(url_list.split("\n"))

    if @invalid_bookmarks.present?
      render :new_batch
    else
      bookmarks.map(&:save!)
      flash[:notice] = "All the links have been added"
      redirect_to user_bookmarks_path
    end
  end

  def update
    bookmark_params = params.require(:user_bookmark).permit(:url, :tag_list)
    @bookmark = UserBookmark.find(params[:id])

    if @bookmark.update_attributes(bookmark_params)
      flash[:notice] = 'Bookmark was successfully updated.'
      redirect_to @bookmark
    else
      render action: 'show'
    end
  end

  def update_info
    @bookmark = UserBookmark.find(params[:id])
    @bookmark.fetch_url_info
    @bookmark.save!

    flash[:notice] = 'Info updated'
    redirect_to :back
  end

  def destroy
    @bookmark = UserBookmark.find(params[:id])
    @bookmark.destroy

    redirect_to action: :index
  end
end
