class Task
  include Mongoid::Document
  field :_id,type: BSON::ObjectId
  field :task_list_id,type: BSON::ObjectId
  field :task_title,type:String
  field :task_remindDate,type:DateTime
  field :task_isComplete ,type:Boolean
  field :task_creatTime  ,type:DateTime
  field :task_isRemind ,type:Boolean
  field :task_isRepeat ,type:Boolean
  field :task_notes ,type:String
  field :task_prl  ,type:Integer
  field :task_order ,type:Integer




  has_many :task_actors, as: :task_actor_rlt,autosave: true, dependent: :delete_all
  has_many :subtasks, as: :subtask_rlt,autosave: true,  dependent: :delete_all
  has_many :tags,as: :tag_rlt, autosave: true
  belongs_to :task_list
end
