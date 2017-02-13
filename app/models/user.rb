class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :confirmable

  has_many :assets
  belongs_to :major, :class_name => 'Major', :foreign_key => 'major_id'

  def to_s
    "User: #{id}, #{email}"
  end
end
