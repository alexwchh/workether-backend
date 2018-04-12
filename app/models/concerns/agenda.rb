class Agenda
  include Mongoid::Document
  field :agenda_title, type:String
  field :agenda_start_time ,type:DateTime
  field :agenda_end_time ,type:DateTime
  field :agenda_mode ,type:Integer
  field :agenda_isRepeat ,type:Boolean  
  field :agenda_isRemind ,type:Boolean
  

  has_many :agenda_actors,autosave: true,  dependent: :delete_all
  belongs_to :agenda_rlt,polymorphic: true
end
