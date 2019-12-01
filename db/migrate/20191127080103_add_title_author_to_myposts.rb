class AddTitleAuthorToMyposts < ActiveRecord::Migration[5.1]
  def change
    add_column :myposts, :title, :string
    add_column :myposts, :author, :string
  end
end
