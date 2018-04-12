class ProjectActor
  include Mongoid::Document
  field:user_id,type: BSON::ObjectId
  belongs_to :project_actor_rlt,polymorphic: true
end
