module Retrospect
  class Commit
    include DataMapper::Resource
    
    property :id,           Serial
    property :hash,         String, :nullable => false
    property :message,      String, :length => 255
    property :author,       Author, :length => 255
    property :committed_at, DateTime
    
    timestamps :at
    
    belongs_to :project, :class_name => "Retrospect::Project",
                         :child_key => [:project_id]
  end
end
