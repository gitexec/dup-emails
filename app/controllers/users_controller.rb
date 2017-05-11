require 'set'
class UsersController < ApplicationController
  def new
    @user = User.new
  end

  def show
    #TODO
    # @emails = User.all(:select => :email)
  end

  def create
    emails = remove_duplicated_email params[:user][:email_collection_attributes]
    #TODO: Create signup process and write the rspecs
    user = User.new(user_params)
    if user.save
      flash.now[:notice] = "created successfully created"
      # redirect_to main_app.show_path
    else
      flash.now[:notice] = "No created"
    end
      redirect_to main_app.root_path
  end

  #TODO: Allow email generated automally to be whitelisted
  def user_params
    params.require(:user).permit(:name, email_collection_attributes: [:alias])
  end

  #TODO: make it private/protected.
  # protected
  #cleaner code
  def remove_duplicated_email emails
    if emails.blank?
      return
    end
    if emails.values.count <= 1
      return
    end
    noDupsEmails = {}
    emails.each do |k, v|
      noDupsEmails[v] = 1
    end
    noDupsEmails.keys
  end
end
