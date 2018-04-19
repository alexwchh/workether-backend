class Subtask
  include Mongoid::Document
  field :_id,type: BSON::ObjectId
  field :task_id,type: BSON::ObjectId
  field :task_title,type:String
  field :task_remindDate,type:DateTime
  field :task_isComplete ,type:Boolean
  field :task_creatTime  ,type:DateTime
  field :task_isRemind ,type:Boolean
  field :task_isRepeat ,type:Boolean
  field :task_notes ,type:String
  field :task_prl  ,type:Integer
  field :task_order ,type:Integer

  belongs_to :subtask_rlt,polymorphic: true
end
