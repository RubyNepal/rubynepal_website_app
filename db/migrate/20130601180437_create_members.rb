class CreateMembers < ActiveRecord::Migration
  def change
    create_table :members do |t|
      t.string :full_name
      t.string :email
      t.string :twitter
      t.string :github
      t.string :linkedin
      t.string :short_bio
      t.text :employement
      t.boolean :active, :default => false

      t.timestamps
    end
  end
end
