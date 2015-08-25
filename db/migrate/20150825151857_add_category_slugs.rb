class AddCategorySlugs < ActiveRecord::Migration
  def change
    add_column :categories, :slugs, :string
  end
end
