class UsersController < ApplicationController
  load_and_authorize_resource

  before_action :set_user, only: [:show, :edit, :update]
  before_action :set_user_by_user_id, only: [:reopen]

  def index
    @users = User.all
  end

  def show
  end

  def edit
  end

  def reopen
    @user.update_attribute(:complete, false)
    redirect_to @user
  end

  # PATCH/PUT /users/1
  # PATCH/PUT /users/1.json
  def update
    if @user.complete == false && user_params[:complete] == 'true'
      UserMailer.confirm_email(@user).deliver_later
    end

    respond_to do |format|
      if @user.update(user_params)
        format.html { redirect_to @user, notice: 'User was successfully updated.' }
        format.json { render :show, status: :ok, location: @user }
      else
        format.html { render :edit }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  def admin?
    self.admin
  end

  private
  def set_user
    @user = User.find(params[:id])
  end

  def set_user_by_user_id
    @user = User.find(params[:user_id])
  end

    # Never trust parameters from the scary internet, only allow the white list through.
  def user_params
    params.require(:user).permit(:name, :major_id, :complete)
  end

end
