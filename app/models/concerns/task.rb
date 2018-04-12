class Task
  include Mongoid::Document
  field :task_title,type:String
  field :task_remindDate,type:String
  field :task_isComplete ,type:String
  field :task_creatTime  ,type:String
  field :task_isRemind ,type:String
  field :task_isRepeat ,type:String
  field :task_notes ,type:String
  field :task_prl  ,type:String




  has_many :task_actors, as: :task_actor_rlt,autosave: true, dependent: :delete_all
  has_many :subtasks, as: :subtask_rlt,autosave: true,  dependent: :delete_all
  has_many :tags,as: :tag_rlt, autosave: true
  belongs_to :task_list
end
