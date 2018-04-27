# encoding: UTF-8

require 'sinatra'
require './block'

b = Blockchain.new

get '/' do 
	b.all_chains.to_s
end

get '/mine' do
	b.mining.to_s
end