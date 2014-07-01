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
    @message = Message.new(params[:message])
    if @message.save
      redirect to("/messages/#{@message.id}")
    else
      erb :"messages/new"
    end
  end



end