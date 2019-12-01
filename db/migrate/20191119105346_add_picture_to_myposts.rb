class AddPictureToMyposts < ActiveRecord::Migration[5.1]
  def change
    add_column :myposts, :picture, :string
    add_column :myposts, :another_picture, :string
  end
end
