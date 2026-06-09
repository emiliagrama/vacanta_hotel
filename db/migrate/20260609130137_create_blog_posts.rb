class CreateBlogPosts < ActiveRecord::Migration[7.1]
  def change
    create_table :blog_posts do |t|
      t.string :title
      t.string :slug
      t.text :excerpt
      t.text :body
      t.boolean :published, default: false, null: false
      t.datetime :published_at

      t.timestamps
    end
  end
end
