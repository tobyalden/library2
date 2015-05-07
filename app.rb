require('pg')
require('sinatra')
require('sinatra/reloader')
require('./lib/book')
require('./lib/author')
require('./lib/joinhelper')
require('./lib/copy')
also_reload('lib/**/*.rb')

DB = PG.connect({:dbname => 'library'})

get('/') do
  erb(:index)
end

get('/search') do
  search_field = params.fetch('search_field')
  found_book_id = Book.get_id_by_title(search_field)
  found_author_id = Author.get_id_by_name(search_field)
  if found_book_id.!=(nil)
    @id = found_book_id
    @title = Book.find(@id).title()
    @authors = JoinHelper.authors_to_s(JoinHelper.find_authors_by_book_id(@id))
    @number_of_copies = Copy.number_of_copies(@id)
    erb(:book)
  elsif found_author_id.!=(nil)
    @books = JoinHelper.find_books_by_author_id(found_author_id)
    erb(:search_results)
  else
    erb(:search_fail)
  end
end

get('/books') do
  @books = Book.all()
  erb(:books)
end

post('/books') do
  name = params.fetch('name')
  author_id = Author.get_id_by_name(name)
  if author_id.==(nil)
    author = Author.new({:name => name, :id => nil})
    author.save()
    author_id = author.id()
  end
  title = params.fetch('title')
  book = Book.new({:title => title, :id => nil})
  book.save()
  JoinHelper.add_author_book_pair({:author => Author.find(author_id), :book => book})
  @books = Book.all()
  erb(:books)
end

get('/book/:id') do
  @id = params.fetch('id').to_i()
  @title = Book.find(@id).title()
  @authors = JoinHelper.authors_to_s(JoinHelper.find_authors_by_book_id(@id))
  @number_of_copies = Copy.number_of_copies(@id)
  erb(:book)
end

post('/book/:id') do
  @id = params.fetch('id').to_i()
  @title = Book.find(@id).title()
  name = params.fetch('another_author')
  another_author = Author.new({:name => name, :id => nil})
  another_author.save()
  JoinHelper.add_author_book_pair({:author => another_author, :book => Book.find(@id)})
  @authors = JoinHelper.authors_to_s(JoinHelper.find_authors_by_book_id(@id))
  @number_of_copies = Copy.number_of_copies(@id)
  erb(:book)
end

post('/add_copies/:id') do
  @id = params.fetch('id').to_i()
  number_of_copies_to_add = params.fetch('number_of_copies').to_i()
  number_of_copies_to_add.times() do
    copy = Copy.new({:book_id => @id})
    copy.save()
  end
  @title = Book.find(@id).title()
  @authors = JoinHelper.authors_to_s(JoinHelper.find_authors_by_book_id(@id))
  @number_of_copies = Copy.number_of_copies(@id)
  erb(:book)
end

patch('/book/:id') do
  new_title = params.fetch('new_title')
  @id = params.fetch('id').to_i()
  book = Book.find(@id)
  book.update({:title => new_title})
  @title = book.title()
  @authors = JoinHelper.authors_to_s(JoinHelper.find_authors_by_book_id(@id))
  @number_of_copies = Copy.number_of_copies(@id)
  erb(:book)
end

delete('/book/:id') do
  @id = params.fetch('id').to_i()
  book = Book.find(@id)
  book.delete()
  @books = Book.all()
  erb(:books)
end
