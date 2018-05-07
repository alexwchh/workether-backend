class Share
  include Mongoid::Document
  field :_id,type: BSON::ObjectId
  field :project_id,type: BSON::ObjectId
  field :share_title,type:String
  field :share_content,type:String

  field :share_creatTime,type:DateTime
  field :last_modified_time,type:Boolean
  has_many :share_comments, as: :share_comment_rlt,autosave: true, dependent: :delete_all

  # has_many :share_comments, autosave: true,  dependent: :delete_all
  belongs_to :share_rlt,polymorphic: true
end
