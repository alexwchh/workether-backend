class TaskActor
  include Mongoid::Document
  field:user_id,type: BSON::ObjectId
  belongs_to :task_actor_rtl,polymorphic: true
end
