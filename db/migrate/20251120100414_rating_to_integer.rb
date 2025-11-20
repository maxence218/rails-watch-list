class RatingToInteger < ActiveRecord::Migration[7.1]
  def change
    change_column :movies, :rating, :integer
  end
end
