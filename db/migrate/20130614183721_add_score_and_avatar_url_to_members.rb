class AddScoreAndAvatarUrlToMembers < ActiveRecord::Migration
  def change
    add_column :members, :score, :integer, :default => 0
    add_column :members, :avatar_url, :string
  end
end
