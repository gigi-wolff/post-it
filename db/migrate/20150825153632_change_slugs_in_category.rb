class ChangeSlugsInCategory < ActiveRecord::Migration
  def change
    rename_column :categories, :slugs, :slug
  end
end
