class RemoveNoOfLikesFromProducts < ActiveRecord::Migration
  def change
  	remove_column :products, :no_of_likes
  end

end
