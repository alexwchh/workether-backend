class TaskComment
  
  include Mongoid::Document
  field :_id,type: BSON::ObjectId
  field :task_id,type: BSON::ObjectId

  field :commenter,type:String
  field :comment_content, type:String
  field :comment_time,type: DateTime 
  belongs_to :comment_rlt,polymorphic: true
end
