class AddMajorRefToUser < ActiveRecord::Migration[5.0]
  def change
    add_reference :users, :major, foreign_key: true
  end
end
