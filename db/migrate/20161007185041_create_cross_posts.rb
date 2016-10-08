class CreateCrossPosts < ActiveRecord::Migration
  def change
    create_table :cross_posts do |t|
      t.integer :post_id, null: false
      t.integer :sub_id, null: false
      t.timestamps
    end

    add_index :cross_posts, [:post_id, :sub_id], unique: true
  end
end
