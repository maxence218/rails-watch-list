class BookmarksController < ApplicationController
  def create
    @list = List.find(params[:list_id])
    @bookmark = @list.bookmarks.new(bookmark_params)

    if @bookmark.save
      redirect_to @list
    else
      @bookmarks = @list.bookmarks
      render "lists/show", status: :unprocessable_entity
    end
  end


  def destroy
    bookmark = Bookmark.find(params[:id])
    list = bookmark.list
    bookmark.delete
    redirect_to list_path(list)
  end

  private
  def bookmark_params
    params.require(:bookmark).permit(:comment, :movie_id)
  end
end
