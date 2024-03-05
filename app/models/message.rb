class Message < ApplicationRecord
  belongs_to :user
  belongs_to :group
  after_create_commit { broadcast_append_to group }
  before_create :confirm_member
  def confirm_member
    return unless group.is_private

    is_member = Member.where(user_id: user.id, group_id: group.id).first
    throw :abort unless is_member
  end
end
