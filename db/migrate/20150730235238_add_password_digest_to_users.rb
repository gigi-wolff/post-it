class AddPasswordDigestToUsers < ActiveRecord::Migration
  #must be called password_digest
  def change
    add_column :users, :password_digest, :string
  end
end
