class Copy

  attr_reader(:id, :book_id, :copy_number, :due_date)

  define_method(:initialize) do |attributes|
    @id = nil
    @book_id = attributes[:book_id]
    @copy_number = attributes[:copy_number]
    @due_date = attributes[:due_date]
  end

end
