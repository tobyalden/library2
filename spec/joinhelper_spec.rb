require('spec_helper')

describe(JoinHelper) do

  describe('.all_authors_books') do
    it('returns the author and book ids of the authors_books joined table') do
      expect(JoinHelper.all_authors_books()).to(eq([]))
    end
  end

  describe('.add_author_book_pair') do
    it('saves a book and author in the authors_books joined table') do
      author = Author.new({:name => 'J.R. Tolkien', :id => nil})
      author.save()
      book = Book.new({:title => 'The Hobbit', :id => nil})
      book.save()
      JoinHelper.add_author_book_pair({:author => author, :book => book})
      expect(JoinHelper.all_authors_books()).to(eq([{:author_id => author.id(), :book_id => book.id()}]))
    end
  end

  describe('.find_books_by_author_id') do
    it('returns all the books by a given author') do
      author = Author.new({:name => 'J.R. Tolkien', :id => nil})
      author.save()
      book = Book.new({:title => 'The Hobbit', :id => nil})
      book.save()
      JoinHelper.add_author_book_pair({:author => author, :book => book})
      expect(JoinHelper.find_books_by_author_id(author.id())).to(eq([book]))
    end
  end

  describe('.find_authors_by_book_id') do
    it('returns all the authors of a given book') do
      author = Author.new({:name => 'J.R. Tolkien', :id => nil})
      author.save()
      book = Book.new({:title => 'The Hobbit', :id => nil})
      book.save()
      JoinHelper.add_author_book_pair({:author => author, :book => book})
      expect(JoinHelper.find_authors_by_book_id(book.id())).to(eq([author]))
    end
  end
end
