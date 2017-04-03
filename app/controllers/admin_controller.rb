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
          id = "#{user.last_name.parameterize.upcase}_#{user.first_name.parameterize}_#{user.major.name.parameterize}_#{user.email.parameterize}"
          [File.open(asset.file.path), "#{user.major.name.parameterize}/#{id}/#{asset.file_file_name}"]
        end
        zipline(files, "all.zip")
      end
    end
  end
end
