class TaskList
  include Mongoid::Document
  field :task_list_title,type:String
  field :task_list_sequence,type:Integer
  field :task_list_creatTime,type:DateTime
  has_many :tasks, autosave: true,  dependent: :delete_all
  belongs_to :task_list_rlt,polymorphic: true
  

end
