require('pg')
require('sinatra')
require('sinatra/reloader')
require('./lib/book')
require('./lib/author')
require('./lib/joinhelper')
also_reload('lib/**/*.rb')

DB = PG.connect({:dbname => 'library'})

get('/') do
  erb(:index)
end

get('/books') do
  @books = Book.all()
  erb(:books)
end

post('/books') do
  name = params.fetch('name')
  author = Author.new({:name => name, :id => nil})
  author.save()

  title = params.fetch('title')
  book = Book.new({:title => title, :author => author})
  book.save()

  JoinHelper.add_author_book_pair({:author => author, :book => book})

  @books = Book.all()
  erb(:books)
end

get('/book/:id') do
  @id = params.fetch('id').to_i()
  @title = Book.find(@id).title()
  @author = JoinHelper.find_authors_by_book_id(@id).first().name()
  erb(:book)
end

patch('/book/:id') do
  new_title = params.fetch('new_title')
  id = params.fetch('id').to_i()
  book = Book.find(id)
  book.update({:title => new_title})
  @title = book.title()
  @author = JoinHelper.find_authors_by_book_id(id).first().name()
  erb(:book)
end

delete('/book/:id') do
  id = params.fetch('id').to_i()
  book = Book.find(id)
  book.delete()
  @books = Book.all()
  erb(:books)
end
