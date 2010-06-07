require 'rubygems'
require 'sinatra'
require 'sass'
require 'erb'
require 'json'
require 'twitter'

get '/' do
    erb :dashboard
end

post '/update' do
    content_type :json
    httpauth = Twitter::HTTPAuth.new(params[:user], params[:pass])
    client = Twitter::Base.new(httpauth)
    {:tweets => client.friends_timeline.map{|u| {:username => u.user.screen_name, :status => u.text, :id => u.id}}}.to_json
end

get '/stylesheet.css' do
    content_type 'text/css', :charset => 'utf-8'
    sass :stylesheet
end