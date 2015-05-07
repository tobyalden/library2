require('spec_helper')

describe('Copy') do
  describe('#copy_number') do
    it('return the copy number of a copy') do
      test_copy = Copy.new({:copy_number => 2, :book_id => nil, :due_date => nil, :id => nil})
      expect(test_copy.copy_number()).to(eq(2))
    end
  end

  describe('#book_id') do
    it('return the book id of a copy') do
      test_copy = Copy.new({:copy_number => 2, :book_id => 1, :due_date => nil, :id => nil})
      expect(test_copy.book_id()).to(eq(1))
    end
  end

  describe('#due_date') do
    it('return the due date number of a copy') do
      test_copy = Copy.new({:copy_number => 2, :book_id => 1, :due_date => '2015-03-01', :id => nil})
      expect(test_copy.due_date()).to(eq('2015-03-01'))
    end
  end

  describe('#id') do
    it('return the copy id of a copy') do
      test_copy = Copy.new({:copy_number => 2, :book_id => 1, :due_date => '2015-03-01', :id => nil})
      expect(test_copy.id()).to(eq(nil))
    end
  end

  describe('.all') do
    it('returns all the copies saved in the database') do
      test_copy = Copy.new({:copy_number => 2, :book_id => 1, :due_date => '2015-03-01', :id => nil})
      expect(Copy.all()).to(eq([]))
    end
  end

  describe('#save') do
    it('saves a copy to the database') do
      test_copy = Copy.new({:copy_number => 2, :book_id => 1, :due_date => '2015-03-01 00:00:00', :id => nil})
      test_copy.save()
      expect(Copy.all()).to(eq([test_copy]))
    end
  end

  describe('.find') do
    it('returns a copy based on the copy id') do
      test_copy = Copy.new({:copy_number => 2, :book_id => 1, :due_date => '2015-03-01 00:00:00', :id => nil})
      test_copy.save()
      expect(Copy.find(test_copy.id())).to(eq(test_copy))
    end
  end

end
