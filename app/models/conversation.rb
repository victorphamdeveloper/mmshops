class Conversation < ActiveRecord::Base
  attr_accessible :receiver_id, :sender_id
  belongs_to :sender, :class_name => "User"
  belongs_to :receiver, :class_name => "User"

  has_many :messages, foreign_key: :conversation_id, dependent: :destroy
end
