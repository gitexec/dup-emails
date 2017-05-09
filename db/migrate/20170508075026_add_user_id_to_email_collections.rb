class AddUserIdToEmailCollections < ActiveRecord::Migration
  def change
    add_column :email_collections, :user_id, :integer
  end
end
