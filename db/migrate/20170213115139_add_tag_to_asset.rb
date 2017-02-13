class AddTagToAsset < ActiveRecord::Migration[5.0]
  def change
    add_column :assets, :tag, :string
  end
end
