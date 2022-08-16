class CreateAlbumsTagsJoinTable < ActiveRecord::Migration[7.0]
  def change
    create_join_table :albums, :tags
  end
end
