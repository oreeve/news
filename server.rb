require 'sinatra'
require 'csv'

set :views_folder, File.join(File.dirname(__FILE__), "views")


get '/articles' do
  @articles = []
  CSV.foreach("articles.csv", headers: true, header_converters: :symbol) do |row|
    article = row.to_hash
    @articles << article
  end
  erb :index
end

# get "article[:article_url]" do
#
# end

get '/articles/new' do
  erb :new
end

post '/articles' do

  CSV.open('articles.csv', 'a') do |csv|
    csv << [params[:article_title],params[:article_url],params[:article_desc]]
  end

  redirect '/articles'
end
