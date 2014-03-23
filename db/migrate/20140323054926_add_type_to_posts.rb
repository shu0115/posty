class AddTypeToPosts < ActiveRecord::Migration
  def change
    add_column :posts, :type, :string, default: 'Post::ActivePost'
    add_column :posts, :archive_at, :timestamp
  end
end
