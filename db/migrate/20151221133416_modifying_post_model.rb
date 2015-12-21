class ModifyingPostModel < ActiveRecord::Migration
	def change
		remove_column :posts, :content
		add_column :posts, :url, :string
	end
end
