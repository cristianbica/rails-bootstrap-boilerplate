class AccountsController < ApplicationController
  
  inherit_resources
  actions :edit, :update

  protected
  def resource
    current_user
  end
  
  def smart_resource_url
    edit_account_path
  end
  
end
