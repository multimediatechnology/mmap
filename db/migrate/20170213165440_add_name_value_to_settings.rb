class AddNameValueToSettings < ActiveRecord::Migration[5.0]
  def change
    add_column :settings, :name, :string
    add_column :settings, :value, :string
  end
end
