ActiveAdmin.register Post do
  actions :all,:except => :edit


  scope :published
  scope :unpublished
  # See permitted parameters documentation:
# https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
#
  permit_params :user,:title,:body
#
# or
#
# permit_params do
#   permitted = [:permitted, :attributes]
#   permitted << :other if params[:action] == 'create' && current_user.admin?
#   permitted
  # end
  form do |f|
    f.inputs 'Details' do
      f.input :user,to: :user_id
      f.input :title
      f.input :body
    end
    actions
  end

  index do
    column :id
    column :title
    column :body
    column :username
    actions
  end

  
  show do
    h3 post.title
    div do
      simple_format post.body
    end
  end
end
