ActiveAdmin.register Post do
  actions :all,:except => :edit

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
      f.input :user,to: :email
      f.input :body
    end
    actions
  end

  show do
    h3 post.title
    div do
      simple_format post.body
    end
  end
end
