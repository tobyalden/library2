require('spec_helper')

describe('Copy') do

  describe('#book_id') do
    it('return the book id of a copy') do
      test_copy = Copy.new({:book_id => 1, :id => nil})
      expect(test_copy.book_id()).to(eq(1))
    end
  end

  describe('#id') do
    it('return the copy id of a copy') do
      test_copy = Copy.new({:book_id => 1, :id => nil})
      expect(test_copy.id()).to(eq(nil))
    end
  end

  describe('.all') do
    it('returns all the copies saved in the database') do
      test_copy = Copy.new({:book_id => 1, :id => nil})
      expect(Copy.all()).to(eq([]))
    end
  end

  describe('#save') do
    it('saves a copy to the database') do
      test_copy = Copy.new({:book_id => 1, :id => nil})
      test_copy.save()
      expect(Copy.all()).to(eq([test_copy]))
    end
  end

  describe('.find') do
    it('returns a copy based on the copy id') do
      test_copy = Copy.new({:book_id => 1, :id => nil})
      test_copy.save()
      expect(Copy.find(test_copy.id())).to(eq(test_copy))
    end
  end

end
