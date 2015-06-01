require 'rubygems'
require 'bundler'

ENV['RACK_ENV'] ||= 'development'

ENV['BUNDLE_GEMFILE'] ||= File.expand_path('../Gemfile', __FILE__)
require 'bundler/setup' if File.exists?(ENV['BUNDLE_GEMFILE'])
Bundler.require(:default, ENV['RACK_ENV'])

require 'sinatra'
require 'sinatra/reloader' if development?
require 'sinatra/partial'
require 'sinatra/static_assets'

require './app'