class Copy

  attr_reader(:id, :book_id)

  define_method(:initialize) do |attributes|
    @id = attributes[:id]
    @book_id = attributes[:book_id]
  end

  define_method(:==) do |other_copy|
    return @book_id == other_copy.book_id()
  end

  define_method(:save) do
    result = DB.exec("INSERT INTO copies (book_id) VALUES (#{@book_id}) RETURNING id;")
    @id = result.first().fetch('id').to_i()
  end

  define_singleton_method(:all) do
    returned_copies = DB.exec('SELECT * FROM copies;')
    copies = []
    returned_copies.each() do |copy|
      book_id = copy.fetch('book_id').to_i()
      id = copy.fetch('id').to_i()
      copies.push(Copy.new({:book_id => book_id, :id => id}))
    end
    copies
  end

  define_singleton_method(:find) do |search_id|
    returned_copy = DB.exec("SELECT * FROM copies WHERE id = #{search_id};")
    if !returned_copy.values().empty?()
      book_id = returned_copy.first().fetch('book_id').to_i()
      id = returned_copy.first().fetch('id').to_i()
      return Copy.new({:book_id => book_id, :id => id})
    end
    return nil
  end

end
