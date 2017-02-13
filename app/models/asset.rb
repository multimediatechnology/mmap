class Asset < ApplicationRecord
  belongs_to :user

  Paperclip.interpolates :user_name do |attachment, styles|
    attachment.instance.user.email
  end

  has_attached_file :file, path: ':rails_root/public/system/:user_name/:filename', url: '/system/:user_name/:filename'
  validates :file, attachment_presence: true
  validates_with AttachmentSizeValidator, attributes: :file, less_than: 1.gigabytes
  do_not_validate_attachment_file_type :file

  enum type: [:cv, :movie, :audio, :image, :concept, :sketch, :storyboard]

  def to_s
    "Asset: #{id} → #{file_file_name}"
  end
end
