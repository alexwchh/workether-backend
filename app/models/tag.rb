class Tag
  include Mongoid::Document
  field :_id,type: BSON::ObjectId
  field :task_id,type: BSON::ObjectId
  field :tag_title, type:String
  belongs_to :tag_rlt,polymorphic: true
end
