class ShareComment
  include Mongoid::Document
  field :_id,type: BSON::ObjectId
  field :share_id,type: BSON::ObjectId

  field :commenter,type:String
  field :comment_content, type:String
  field :comment_time,type: DateTime 
  belongs_to :share_comment_rlt,polymorphic: true
end
