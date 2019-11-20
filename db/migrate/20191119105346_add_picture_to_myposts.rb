class AddPictureToMyposts < ActiveRecord::Migration[5.1]
  def change
    add_column :myposts, :picture, :string
  end
end
