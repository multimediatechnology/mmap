class AdminController < ApplicationController
  include ActionController::Streaming
  include Zipline

  authorize_resource :class => false

  def home
  end

  def download
    respond_to do |format|
      format.zip do
        files = Asset.all.map do |asset|
          user = asset.user
          [File.open(asset.file.path), "#{user.major.name.parameterize}/#{user.name.parameterize}/#{asset.file_file_name}"]
        end
        zipline(files, "all.zip")
      end
    end
  end
end
