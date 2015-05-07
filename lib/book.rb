class Book

  attr_reader(:title, :id)

  define_method(:initialize) do |attributes|
    @title = attributes[:title]
    @id = attributes[:id]
    @author = attributes[:author]
  end

  define_method(:==) do |other_book|
    return @title == other_book.title()
  end

  define_method(:save) do
    result = DB.exec("INSERT INTO books (title) VALUES ('#{@title}') RETURNING id;")
    @id = result.first().fetch('id').to_i()
  end

  define_method(:update) do |attributes|
    @title = attributes[:title]
    DB.exec("UPDATE books SET title = '#{@title}' WHERE id = #{@id}")
  end



  define_method(:delete) do
    DB.exec("DELETE FROM books WHERE id = #{@id};")
  end

  define_singleton_method(:all) do
    returned_books = DB.exec('SELECT * FROM books;')
    books = []
    returned_books.each() do |book|
      title = book.fetch('title')
      id = book.fetch('id').to_i()
      books.push(Book.new({:title => title, :id => id}))
    end
    books
  end

  define_singleton_method(:find) do |search_id|
    returned_book = DB.exec("SELECT * FROM books WHERE id = #{search_id};")
    if !returned_book.values().empty?()
      title = returned_book.first().fetch('title')
      id = returned_book.first().fetch('id').to_i()
      return Book.new({:title => title, :id => id})
    end
    return nil
  end

end
