class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :confirmable

  has_many :assets
  belongs_to :major, :class_name => 'Major', :foreign_key => 'major_id'

  def name
    return "#{first_name} #{last_name}"
  end

  def assets_cnt
    assets.length
  end

  def last_update
    if assets.length == 0
      return DateTime.new(1992, 1, 21)
    end

    assets.reduce(DateTime.new) do |latestUpdate, asset|
      latestUpdate < asset.updated_at ? asset.updated_at : latestUpdate
    end
  end

  def to_s
    "User: #{id}, #{email}"
  end
end
