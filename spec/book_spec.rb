require('spec_helper')

describe(Book) do

  describe('#title') do
    it('returns the title of the book') do
      test_book = Book.new({:title => 'The Hobbit', :id => nil})
      expect(test_book.title()).to(eq('The Hobbit'))
    end
  end

  describe('#id') do
    it('returns the id of the book') do
      test_book = Book.new({:title => 'The Hobbit', :id => nil})
      expect(test_book.id()).to(eq(nil))
    end
  end

  describe('#==') do
    it('compares two books and returns true if their titles are the same') do
      test_book = Book.new({:title => 'The Hobbit', :id => nil})
      test_book2 = Book.new({:title => 'The Hobbit', :id => nil})
      expect(test_book.==(test_book2)).to(eq(true))
    end
  end

  describe('.all') do
    it('returns all the books stored in the database') do
      expect(Book.all()).to(eq([]))
    end
  end

  describe('#save') do
    it('saves the book to the database') do
      test_book = Book.new({:title => 'The Hobbit', :id => nil})
      test_book.save()
      expect(Book.all()).to(eq([test_book]))
    end
  end

  describe('.find') do
    it('finds a book in the database by its id') do
      test_book = Book.new({:title => 'The Hobbit', :id => nil})
      test_book.save()
      expect(Book.find(test_book.id())).to(eq(test_book))
    end

    it('returns nil if the book cannot be found in the database') do
      expect(Book.find(-1)).to(eq(nil))
    end
  end

  describe('#update') do
    it('lets you update books in the database') do
      test_book = Book.new({:title => 'The Hobbit', :id => nil})
      test_book.save()
      test_book.update({:title => 'Lord of the Rings'})
      expect(Book.find(test_book.id()).title()).to(eq(test_book.title()))
    end
  end

  describe('#delete') do
    it('lets you delete a book in the database') do
      test_book = Book.new({:title => 'The Hobbit', :id => nil})
      test_book.save()
      test_book2 = Book.new({:title => 'Lord of the Rings', :id => nil})
      test_book2.save()
      test_book.delete()
      expect(Book.all()).to(eq([test_book2]))
    end
  end

  describe('#assign_author') do
    it('lets you add an author to a book') do

    end
  end
end
