class CreateTables < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :email, :password_hash
      t.timestamps
    end

    create_table :tags do |t|
      t.string :name
      t.timestamps
    end

    create_table :posts do |t|
      t.string :title
      t.text :description
      t.references :user
      t.timestamps
    end

    create_table :posts_tags do |t|
      t.references :post, :tag
    end
  end
end
