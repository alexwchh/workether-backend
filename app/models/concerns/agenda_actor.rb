class AgendaActor
  include Mongoid::Document
  field:user_id,type: BSON::ObjectId
  belongs_to :agenda
  
end
