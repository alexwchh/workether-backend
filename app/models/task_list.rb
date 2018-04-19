class TaskList
  include Mongoid::Document
  field :_id,type: BSON::ObjectId
  field :project_id,type: BSON::ObjectId
  field :task_list_title,type:String
  field :task_list_order,type:Integer
  field :task_list_creatTime,type:DateTime
  field :task_list_isActive,type:Boolean
  has_many :tasks, autosave: true,  dependent: :delete_all
  belongs_to :task_list_rlt,polymorphic: true
  
  

end
