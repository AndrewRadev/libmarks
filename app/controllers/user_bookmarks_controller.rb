class UserBookmarksController < ApplicationController
  before_filter :require_user

  def index
    @bookmarks = current_user.bookmarks.order('created_at DESC').includes(:tags)
  end

  def show
    @bookmark = current_user.bookmarks.find(params[:id])
  end

  def new
    @bookmark = current_user.bookmarks.build
  end

  def create
    bookmark_params = params.require(:user_bookmark).permit(:url, :tag_list)
    @bookmark = current_user.bookmarks.build(bookmark_params)

    if @bookmark.valid?
      @bookmark.save!
      @bookmark.fetch_url_info_later

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

    urls = url_list.split("\n")
    bookmarks, @invalid_bookmarks = UserBookmark.create_from_list(current_user, urls)

    if @invalid_bookmarks.present?
      render :new_batch
    else
      bookmarks.map(&:save!)
      bookmarks.map(&:fetch_url_info_later)
      flash[:notice] = "All the links have been added"
      redirect_to user_bookmarks_path
    end
  end

  def update
    bookmark_params = params.require(:user_bookmark).permit(:url, :tag_list)
    @bookmark = current_user.bookmarks.find(params[:id])

    if @bookmark.update_attributes(bookmark_params)
      flash[:notice] = 'Bookmark was successfully updated.'
      redirect_to @bookmark
    else
      render action: 'show'
    end
  end

  def update_info
    @bookmark = current_user.bookmarks.find(params[:id])
    @bookmark.fetch_url_info
    @bookmark.save!

    flash[:notice] = 'Info updated'
    redirect_to :back
  end

  def destroy
    @bookmark = current_user.bookmarks.find(params[:id])
    @bookmark.destroy

    redirect_to action: :index
  end
end
