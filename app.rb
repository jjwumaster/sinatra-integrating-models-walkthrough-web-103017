require_relative 'config/environment'
require_relative 'models/text_analyzer.rb'
require 'pry'

class App < Sinatra::Base
  get '/' do
    erb :index
  end

  post '/' do
    @analyzed_text = TextAnalyzer.new(params[:user_text]).text
    hash = @analyzed_text.split("").inject(Hash.new(0)) do |h, v|
      h[v] += 1
      h
    end
    @letter = hash.max_by {|k, v| v}[0]
    @freq = hash.max_by {|k, v| v}[1]
    erb :results
  end
end
