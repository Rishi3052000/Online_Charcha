class Group < ApplicationRecord
    validates_uniqueness_of :name
    scope :public_groups, -> { where(is_private: false) }
    after_create_commit { broadcast_append_to 'groups' }
    has_many :messages
end
