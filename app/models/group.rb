class Group < ApplicationRecord
    validates_uniqueness_of :name
    scope :public_groups, -> { where(is_private: false) }
    after_create_commit {broadcast_if_public }
    has_many :messages
    has_many :members, dependent: :destroy
    def broadcast_if_public
        broadcast_append_to 'groups' unless is_private
    end
    def self.create_private_group(users, group_name)
        single_group = Group.create(name: group_name, is_private: true)
        users.each do |user|
          Member.create(user_id: user.id, group_id: single_group.id)
        end
        single_group
    end
end
