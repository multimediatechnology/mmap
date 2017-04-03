class AddCompleteBoolToUsers < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :complete, :boolean, :default => false
  end
end
