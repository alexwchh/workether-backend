class Project
  include Mongoid::Document
  field :_id,type: BSON::ObjectId
  field :project_name,type: String
  field :project_create_time, type:DateTime
  field :isStarred, type: Boolean
  field :isActive,type: Boolean
  #field :project_owner,type: String
  has_many :project_actors, as: :project_actor_rlt,autosave: true,  dependent: :delete_all
  has_many :task_lists, as: :task_list_rlt,autosave: true,  dependent: :delete_all
  has_many :agendas,as: :agenda_rlt, autosave: true,  dependent: :delete_all
  belongs_to :user
  
end
