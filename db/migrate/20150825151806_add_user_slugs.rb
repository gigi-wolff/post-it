class AddUserSlugs < ActiveRecord::Migration
  def change
    add_column :users, :slug, :string
  end
end
