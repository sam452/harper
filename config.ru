require 'rubygems'
require 'bundler/setup'
require 'sinatra/base'
Bundler.require

root_dir = File.dirname(__FILE__)
app_file = File.join(root_dir, 'harper.rb')
require app_file

run Harper