class Copy

  attr_reader(:id, :book_id, :copy_number, :due_date)

  define_method(:initialize) do |attributes|
    @id = attributes[:id]
    @book_id = attributes[:book_id]
    @copy_number = attributes[:copy_number]
    @due_date = attributes[:due_date]
  end

  define_method(:==) do |other_copy|
    return @book_id == other_copy.book_id() && @copy_number == other_copy.copy_number() && @due_date == other_copy.due_date()
  end

  define_method(:save) do
    result = DB.exec("INSERT INTO copies (book_id, copy_number, due_date) VALUES (#{@book_id}, #{@copy_number}, '#{@due_date}') RETURNING id;")
    @id = result.first().fetch('id').to_i()
  end

  define_singleton_method(:all) do
    returned_copies = DB.exec('SELECT * FROM copies;')
    copies = []
    returned_copies.each() do |copy|
      book_id = copy.fetch('book_id').to_i()
      copy_number = copy.fetch('copy_number').to_i()
      due_date = copy.fetch('due_date')
      id = copy.fetch('id').to_i()
      copies.push(Copy.new({:book_id => book_id, :copy_number => copy_number, :due_date => due_date, :id => id}))
    end
    copies
  end

end
