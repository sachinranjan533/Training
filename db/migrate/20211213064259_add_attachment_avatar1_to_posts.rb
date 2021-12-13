class AddAttachmentAvatar1ToPosts < ActiveRecord::Migration[6.1]
  def self.up
    change_table :posts do |t|
      t.attachment :avatar1
    end
  end

  def self.down
    remove_attachment :posts, :avatar1
  end
end
