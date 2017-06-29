class Comment < ApplicationRecord
  include PublicActivity::Model
  tracked owner: ->(controller, model ) { controller && controller.current_user }

  belongs_to :user
  validates :body, presence: true
end
