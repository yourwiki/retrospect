$LOAD_PATH << "./lib"
require 'rubygems'
require 'retrospect'

Retrospect.new({
	:database_uri => "sqlite://#{Dir.pwd}/retrospect.db"
})

run Retrospect::App
