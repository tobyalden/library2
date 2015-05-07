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

end
