require 'rubygems'
require 'sinatra'

class MessagesController < ApplicationController

  get '/' do # index page
    @messages = Message.all
    erb :"messages/index"
  end

  get '/messages/new' do 
    @message = Message.new
    erb :"messages/new"
  end

  get '/messages/:id' do 
    @message = Message.find(params[:id])
    erb :"messages/show"
  end

  post '/messages' do 
    @message = Message.new(strong_params)
    if @message.save
      redirect to("/messages/#{@message.id}")
    else
      erb :"messages/new"
    end
  end

  def strong_params
    params[:message].each_with_object({}) do |pair,hash|
      hash[html_safe(pair[0])] = html_safe(pair[1])
    end
  end

  def html_safe(text)
    Rack::Utils.escape_html(text)
  end

end