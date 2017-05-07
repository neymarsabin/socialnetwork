class Addrefencestocomments < ActiveRecord::Migration[5.0]
  def change
    add_reference :comments, :user, index: true
    add_reference :comments, :post, index: true
  end
end
