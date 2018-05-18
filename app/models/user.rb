class User
  include Mongoid::Document
    field :_id,type: BSON::ObjectId
    field :email,type: String
    field :psw,type: String
    field :name,type: String
    has_many :projects, autosave: true,  dependent: :delete_all
end
