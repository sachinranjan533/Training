class Post < ApplicationRecord
    acts_as_paranoid #recover_dependent_associations: false
    validates_as_paranoid
    validates_uniqueness_of_without_deleted [:title,:body]
    has_many :comments,dependent: :destroy
    belongs_to :user
    validates :title,presence: true,length: {minimum: 5,maximum: 10}
    validates :body,presence: true,length: {minimum: 10,maximum: 100}
    has_attached_file :avatar
    #do_not_validate_attachment_content_type :avatar
    validates_attachment :avatar, content_type: { content_type: ["image/jpeg", "image/gif", "image/png"] }
    validates_with AttachmentSizeValidator, attributes: :avatar, in: 100..200.kilobytes
    validates_with AttachmentPresenceValidator,attributes: :avatar
end