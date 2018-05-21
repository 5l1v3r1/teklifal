class Attachment < ApplicationRecord
  mount_uploader :file, AttachmentUploader
  belongs_to :attachmentable, polymorphic: true
end
