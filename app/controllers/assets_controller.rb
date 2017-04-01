class AssetsController < ApplicationController
  include ActionController::Streaming
  include Zipline

  load_and_authorize_resource :user
  load_and_authorize_resource :asset, :through => :user

  before_action :set_user
  before_action :set_asset, only: [:show, :edit, :update, :destroy]

  # GET /users/:user_id/assets
  # GET /users/:user_id/assets.json
  def index
    @assets = @user.assets

    respond_to do |format|
      format.html
      format.json
      format.zip do
        id = "#{@user.last_name.parameterize.upcase}_#{@user.first_name.parameterize}_#{@user.major.name.parameterize}_#{@user.email.parameterize}"
        files = @user.assets.map do |asset|
          [File.open(asset.file.path), "#{@user.major.name.parameterize}/#{id}/#{asset.file_file_name}"]
        end
        zipline(files, "#{id}.zip")
      end
    end
  end

  # GET /users/:user_id/assets/1
  # GET /users/:user_id/assets/1.json
  def show
  end

  # GET /users/:user_id/assets/new
  def new
    @asset = Asset.new
  end

  # GET /users/:user_id/assets/1/edit
  def edit
  end

  # POST /assets
  # POST /assets.json
  def create
    @asset = @user.assets.new(asset_params)

    respond_to do |format|
      if @asset.save
        format.html {
          @assets = @user.assets
          render :layout => false
        }
        format.json { render :show, status: :created, location: [@user, @asset] }
      else
        format.html { render :new }
        format.json { render json: @asset.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /assets/1
  # PATCH/PUT /assets/1.json
  def update
    respond_to do |format|
      if @asset.update(asset_params)
        format.html { redirect_to user_url(@user), notice: 'Asset was successfully updated.' }
        format.json { render :show, status: :ok, location: [@user, @asset] }
      else
        format.html { render :edit }
        format.json { render json: @asset.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /assets/1
  # DELETE /assets/1.json
  def destroy
    @asset.destroy
    respond_to do |format|
      format.html { redirect_to user_url(@user), notice: 'Asset was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_user
    @user = User.find(params[:user_id])
  end

  def set_asset
    @asset = Asset.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def asset_params
    params.require(:asset).permit(:user_id, :file, :tag)
  end
end
