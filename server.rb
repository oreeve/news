require 'sinatra'
require 'csv'
require 'pry'

set :views_folder, File.join(File.dirname(__FILE__), "views")


get '/articles' do
  @articles = []
  CSV.foreach("articles.csv", headers: true, header_converters: :symbol) do |row|
    article = row.to_hash
    @articles << article
    # binding.pry
  end
  erb :index
end

get '/articles/new' do
  erb :new
end

post '/articles' do
  CSV.foreach("articles.csv", headers: true, header_converters: :symbol) do |row|
    if row[:article_url].include?(params[:article_url])
      redirect '/articles/new'
    else
      CSV.open('articles.csv', 'a+') do |csv|
        csv << [params[:article_title],params[:article_url],params[:article_desc]]
      end
    end
  redirect '/articles'
  end
end
