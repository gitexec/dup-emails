class CreateEmailCollections < ActiveRecord::Migration
  def change
    create_table :email_collections do |t|
      t.string :alias

      t.timestamps null: false
    end
  end
end
