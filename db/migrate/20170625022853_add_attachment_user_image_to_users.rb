class AddAttachmentUserImageToUsers < ActiveRecord::Migration
  def self.up
    change_table :users do |t|
      t.attachment :user_image
    end
  end

  def self.down
    remove_attachment :users, :user_image
  end
end
