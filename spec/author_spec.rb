require('spec_helper')

describe(Author) do

  describe('#name') do
    it('returns the name of the author') do
      test_author = Author.new({:name => 'J.R. Tolkien', :id => nil})
      expect(test_author.name()).to(eq('J.R. Tolkien'))
    end
  end

  describe('#id') do
    it('returns the id of the author') do
      test_author = Author.new({:name => 'J.R. Tolkien', :id => nil})
      expect(test_author.id()).to(eq(nil))
    end
  end

  describe('#==') do
    it('compares two authors and returns true if their names are the same') do
      test_author = Author.new({:name => 'J.R. Tolkien', :id => nil})
      test_author2 = Author.new({:name => 'J.R. Tolkien', :id => nil})
      expect(test_author.==(test_author2)).to(eq(true))
    end
  end

  describe('.all') do
    it('returns all the authors stored in the database') do
      expect(Author.all()).to(eq([]))
    end
  end

  describe('#save') do
    it('saves the author to the database') do
      test_author = Author.new({:name => 'J.R. Tolkien', :id => nil})
      test_author.save()
      expect(Author.all()).to(eq([test_author]))
    end
  end

  describe('.find') do
    it('finds a author in the database by its id') do
      test_author = Author.new({:name => 'J.R. Tolkien', :id => nil})
      test_author.save()
      expect(Author.find(test_author.id())).to(eq(test_author))
    end

    it('returns nil if the author cannot be found in the database') do
      expect(Author.find(-1)).to(eq(nil))
    end
  end

  describe('#delete') do
    it('lets you delete an author in the database') do
      test_author = Author.new({:name => 'J.R. Tolkien', :id => nil})
      test_author.save()
      test_author2 = Author.new({:name => 'J.K. Rowling', :id => nil})
      test_author2.save()
      test_author.delete()
      expect(Author.all()).to(eq([test_author2]))
    end
  end

end
