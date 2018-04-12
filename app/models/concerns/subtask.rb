class Subtask
  include Mongoid::Document
  field :subtask_title
  belongs_to :subtask_rlt,polymorphic: true
end
