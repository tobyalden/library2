require('capybara/rspec')
require('./app')
require('spec_helper')

Capybara.app = Sinatra::Application
set(:show_exceptions, false)

describe('the path to the index page', {:type => :feature}) do
  it('displays a welcome page to the library') do
    visit('/')
    expect(page).to have_content('Library')
  end
end

describe('the path to the books page', {:type => :feature}) do
  it('displays a list of books from the library') do
    visit('/')
    click_on('See Books')
    expect(page).to have_content('Here are all the available books in the library:')
  end
end

describe('the path to add a new book to the library', {:type => :feature}) do
  it('displays a form for the user to enter in a new book to add to the library') do
    visit('/')
    click_on('See Books')
    fill_in('title', :with => 'The Hobbit')
    fill_in('name', :with => 'J.R. Tolkien')
    click_button('add_book')
    expect(page).to have_content('The Hobbit')
  end
end

describe('the path to display the information of a book', {:type => :feature}) do
  it('displays a list of book links leading to that books information') do
    book = Book.new({:title => 'The Hobbit', :id => nil})
    book.save()
    author = Author.new({:name => 'J.R. Tolkien', :id => nil})
    author.save()
    JoinHelper.add_author_book_pair({:author => author, :book => book})
    visit('/')
    click_on('See Books')
    click_on(book.id().to_s())
    expect(page).to have_content('The Hobbit')
  end
end

describe('the path to update the information of a book', {:type => :feature}) do
  it('displays a list of book links leading to a form for the user to update that books information') do
    book = Book.new({:title => 'The Hobbit', :id => nil})
    book.save()
    author = Author.new({:name => 'J.R. Tolkien', :id => nil})
    author.save()
    JoinHelper.add_author_book_pair({:author => author, :book => book})
    visit('/')
    click_on('See Books')
    click_on(book.id().to_s())
    fill_in('new_title', :with => 'Lord of the Rings')
    click_button('update_book')
    expect(page).to have_content('Lord of the Rings')
  end
end

describe('the path to delete a book from the library database', {:type => :feature}) do
  it('displays a list of book links leading to a form for the user to delete that book') do
    book = Book.new({:title => 'The Hobbit', :id => nil})
    book.save()
    author = Author.new({:name => 'J.R. Tolkien', :id => nil})
    author.save()
    JoinHelper.add_author_book_pair({:author => author, :book => book})
    visit('/')
    click_on('See Books')
    click_on(book.id().to_s())
    click_on('delete_book')
    expect(page).to have_no_content('The Hobbit')
  end
end

describe('the path to add another author to an existing book', {:type => :feature}) do
  it('displays a button to add an author to a book') do
    book = Book.new({:title => 'The Hobbit', :id => nil})
    book.save()
    author = Author.new({:name => 'J.R. Tolkien', :id => nil})
    author.save()
    JoinHelper.add_author_book_pair({:author => author, :book => book})
    visit('/')
    click_on('See Books')
    click_on(book.id().to_s())
    fill_in('another_author', :with => 'test_author')
    click_button('add_author')
    expect(page).to have_content('test_author')
  end
end

describe('the path to search for books by title') do
  it('displays a search bar and button that takes the user to a list of search results', {:type => :feature}) do
    book = Book.new({:title => 'The Hobbit', :id => nil})
    book.save()
    author = Author.new({:name => 'J.R. Tolkien', :id => nil})
    author.save()
    JoinHelper.add_author_book_pair({:author => author, :book => book})
    visit('/')
    fill_in('search_field', :with => 'The Hobbit')
    click_button('search')
    expect(page).to have_content('The Hobbit by J.R. Tolkien')
  end

  it('displays a search bar and button that takes the user to a list of search results', {:type => :feature}) do
    book = Book.new({:title => 'The Hobbit', :id => nil})
    book.save()
    author = Author.new({:name => 'J.R. Tolkien', :id => nil})
    author.save()
    JoinHelper.add_author_book_pair({:author => author, :book => book})
    visit('/')
    fill_in('search_field', :with => 'Lord of the Rings')
    click_button('search')
    expect(page).to have_content('No search result found')
  end

end
