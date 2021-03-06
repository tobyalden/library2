class Book

  attr_reader(:title, :id)

  define_method(:initialize) do |attributes|
    @title = attributes[:title]
    @id = attributes[:id]
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
    DB.exec("UPDATE books SET title = '#{@title}' WHERE id = #{@id};")
  end

  define_method(:delete) do
    DB.exec("DELETE FROM books WHERE id = #{@id};")

    associated_author_book_pairs = DB.exec("SELECT * FROM authors_books WHERE book_id = #{@id};")
    associated_authors = []
    associated_author_book_pairs.each() do |author_book_pair|
      author = Author.find(author_book_pair.fetch("author_id").to_i())
      associated_authors.push(author)
    end

    DB.exec("DELETE FROM authors_books WHERE book_id = #{@id};")

    associated_authors.each() do |author|
      remaining_author_book_pairs = DB.exec("SELECT * FROM authors_books WHERE author_id = #{author.id()};")
      if(remaining_author_book_pairs.values().empty?())
        author.delete()
      end
    end

    DB.exec("DELETE FROM copies WHERE book_id = #{@id}")

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

  define_singleton_method(:get_id_by_title) do |search_title|
    returned_book_id = DB.exec("SELECT id FROM books WHERE title = '#{search_title}';")
    if !returned_book_id.values().empty?()
      return returned_book_id.first().fetch('id').to_i()
    end
    return nil
  end

  define_singleton_method(:get_available_copy) do |book_id|
    returned_copy_ids = DB.exec("SELECT id FROM copies WHERE book_id = #{book_id};")
    returned_copy_id.each() do |returned_copy_id|
      copy_id = returned_copy_id.first().fetch("id").to_i()
      returned_copy = DB.exec("SELECT * FROM checkouts WHERE copy_id = #{copy_id};")
      if !returned_copy.values().empty?()
        return copy_id
      end
    end
    return nil
  end

end
