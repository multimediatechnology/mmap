class RemoveMajorFromUser < ActiveRecord::Migration[5.0]
  def change
    remove_column :users, :major, :string
  end
end
