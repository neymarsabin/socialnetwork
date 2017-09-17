class Post < ActiveRecord::Base
  #before_save :set_state
  # before_commit :set_state
  # # include PublicActivity::Model
  # # tracked owner: ->(controller,model ) { controller && controller.current_user },
  # #         title: ->(controller, model ) { controller && model.title }

  # # various states of the post
  # # go from unpublished to published 
  # state_machine :state, initial: :unpublished do
  #   event :process do
  #     transition unpublished: :published
  #   end
  # end

  scope :published, -> { where(state: nil) }

  def change_state
    update_attributes(state: 'published')
  end

  # def current_post
  #   return self.id
  # end

  # def self.recommend(current_post)
    
  # end
  
  validates :title,:body, presence: true
  belongs_to :user
  #delegate :email, to: :user
  #delegate :username, to: :user
  has_many :comments,dependent: :destroy

  acts_as_votable

  # extend FriendlyId
  # friendly_id :title, use: :slugged


  def to_param
    "#{id} #{title}".parameterize
  end

  acts_as_taggable

  # private
  # def set_state
  #   self.state = 'unpublished'
  #   true 
  # end
end
