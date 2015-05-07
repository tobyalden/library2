require('rspec')
require('book')
require('author')
require('joinhelper')
require('pg')
require('pry')

DB = PG.connect({:dbname => 'library_test'})

RSpec.configure do |config|
  config.before(:each) do
    DB.exec("DELETE FROM books *;")
    DB.exec("DELETE FROM authors *;")
    DB.exec("DELETE FROM authors_books *;")
  end
end
