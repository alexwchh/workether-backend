class Agenda
  include Mongoid::Document
  field :_id,type: BSON::ObjectId
  field :project_id,type: BSON::ObjectId

  field :agenda_title, type:String
  field :agenda_start_time ,type:DateTime
  field :agenda_isComplete ,type:Boolean
  field :agenda_end_time ,type:DateTime
  field :complete_time, type:DateTime
  field :agenda_repeat ,type:String  
  field :agenda_remind ,type:String
  

  has_many :agenda_actors,autosave: true,  dependent: :delete_all
  belongs_to :agenda_rlt,polymorphic: true
end
