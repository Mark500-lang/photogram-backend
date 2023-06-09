class CreatePosts < ActiveRecord::Migration[7.0]
  def change
    create_table :posts do |t|
      t.string :post_pic
      t.references :user, null: false, foreign_key: true
      t.text :caption

      t.timestamps
    end
  end
end
