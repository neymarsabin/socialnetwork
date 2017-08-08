class AddPermalinkToUsers < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :permalink, :string
  end
end
