class Tag
  include Mongoid::Document
  field :tag_title, type:String
  belongs_to :tag_rlt,polymorphic: true
end
