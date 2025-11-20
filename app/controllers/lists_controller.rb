class ListsController < ApplicationController
  def index
    @lists = List.all
    @newList = List.new
  end

  def show
    @list = List.find(params[:id])
    @bookmarks = Bookmark.all.where("list_id = #{@list.id}")
    @bookmark = Bookmark.new
  end

  def create
    list = List.new(list_params)
    if list.save
      redirect_to lists_path
    else
      render :new, status: :unprocessable_entity
    end
  end

  private

    def list_params
    params.require(:list).permit(:name)
  end
end
