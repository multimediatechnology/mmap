class Major < ApplicationRecord

  has_many :users

  def to_s
    "Name: #{name}"
  end

end
