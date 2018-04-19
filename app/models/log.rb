class Log
  include Mongoid::Document
  field :_id,type: BSON::ObjectId
  field :user_id,type: BSON::ObjectId
  field :source_id,type: BSON::ObjectId
  field :operation,type:String
  field :operation_target,type:String
  field :create_time,type:DateTime

end
