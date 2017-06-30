class Comment < ApplicationRecord
  include PublicActivity::Common
  # tracked except: :destroy, owner: ->(controller, model ) { controller && controller.current_user }

  belongs_to :user
  validates :body, presence: true
end
