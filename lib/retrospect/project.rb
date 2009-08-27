module Retrospect
  class Project
    include DataMapper::Resource
    
    property :id,         Serial
    property :name,       String,   :nullable => false
    property :permalink,  String
    property :repo,       URI,      :nullable => false, :length => 255
    property :branch,     String,   :nullable => true,  :default => "master"
    
    has n, :commits, :class_name => "Retrospect::Commit"
    
    before :save, :set_permalink
    
    before :destroy do
      commits.destroy!
    end
    
    private
    def set_permalink
      attribute_set(:permalink, (name || "").downcase.
        gsub(/'s/, "s").
        gsub(/&/, "and").
        gsub(/[^a-z0-9]+/, "-").
        gsub(/-*$/, ""))
    end
  end
end
