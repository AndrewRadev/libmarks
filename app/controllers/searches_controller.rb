class SearchesController < ApplicationController
  def show
    @tag       = params[:tag]
    @bookmarks = UserBookmark.tagged_with(@tag).order('created_at DESC')
  end
end

