class AddUniqueIndexToBlogPostsSlug < ActiveRecord::Migration[7.1]
  def change
    add_index :blog_posts, :slug, unique: true
  end
end
