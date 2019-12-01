class AddPictureToMicroposts < ActiveRecord::Migration[5.1]
  def change
    add_column :microposts, :picture, :string
    add_column :microposts, :another_picture, :string
  end
end
