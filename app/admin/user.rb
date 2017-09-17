ActiveAdmin.register User do
  actions :all,:except => :edit

  # See permitted parameters documentation:
# https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
#
# permit_params :list, :of, :attributes, :on, :model
  permit_params :admin
  #
# or
#
# permit_params do
#   permitted = [:permitted, :attributes]
#   permitted << :other if params[:action] == 'create' && current_user.admin?
#   permitted
  # end
  index do
    column :id
    column :username
    column :email
    column :created_at
    column :admin
    column :unconfirmed_email
    column :sign_in_count
    column :permalink
    actions
  end

  filter :email
  filter :id
  filter :created_at
  filter :updated_at
end
