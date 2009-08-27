require 'sinatra/base'
require 'dm-core'

require 'retrospect/app'
require 'retrospect/project'
require 'retrospect/commit'

module Retrospect
  def self.new(config)
    self.config = config
    
    DataMapper.setup(:default, self.config[:database_uri])
    DataMapper.auto_upgrade!
  end
  
  def self.default_configuration
    @defaults ||= {
      :database_uri     => "sqlite3::memory:",
      :export_directory => "/tmp/exports",
      :log              => STDOUT
    }
  end
  
  def self.config
    @config ||= default_configuration.dup
  end
  
  def self.config=(options)
    @config = default_configuration.merge(options)
  end
end
