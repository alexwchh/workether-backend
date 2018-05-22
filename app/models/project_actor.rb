class ProjectActor
  include Mongoid::Document
  field :_id,type: BSON::ObjectId
  field :user_id,type: BSON::ObjectId
  field :user_name,type: String
  field :email,type:String
  field :project_id,type: BSON::ObjectId
  belongs_to :project_actor_rlt,polymorphic: true
end
