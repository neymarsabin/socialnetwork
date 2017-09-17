ActiveAdmin.register Post do

  scope :published

  actions :all,:except => :edit


  filter :title
  filter :id
  filter :body
  filter :created_at
  filter :updated_at
  


  
  # scope :published
  # scope :unpublished
  # See permitted parameters documentation:
# https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
#
  permit_params :title,:body,:user_id# ,:admin
#
# or
#
# permit_params do
#   permitted = [:permitted, :attributes]
#   permitted << :other if params[:action] == 'create' && current_user.admin?
#   permitted
  # end
  form do |f|
    f.object.state = 'unpublished'
    f.inputs 'Details' do
      # f.input :admin
      f.input :title
      f.input :body
    end
    actions
  end

  # action_item :view, only: :show do
  #   link_to 'View on site', post_path(post) if post.published?
  # end

  
  index do
    column :id
    column :title
    column :body
    actions
  end

  
  show do
    h3 post.title
    div do
      simple_format post.body
    end
  end
end
