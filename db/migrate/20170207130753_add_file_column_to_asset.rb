class AddFileColumnToAsset < ActiveRecord::Migration[5.0]
  def up
    add_attachment :assets, :file
  end

  def down
    remove_attachment :assets, :file
  end
end
