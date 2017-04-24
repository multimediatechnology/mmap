class AdminController < ApplicationController
  include ActionController::Streaming
  include Zipline

  authorize_resource :class => false

  def home
  end

  def download
    respond_to do |format|
      format.zip do
        files = Asset.includes(:user).all.map do |asset|
          user = asset.user
          file = File.open(asset.file.path) if File.exists?(asset.file.path)
          if file
            id = "#{user.last_name.parameterize.upcase}_#{user.first_name.parameterize}_#{user.major.name.parameterize}_#{user.email.parameterize}"
            [file, "#{user.major.name.parameterize}/#{id}/#{asset.file_file_name}"]
          end
        end
        zipline(files.compact, "all.zip")
      end
    end
  end
end
