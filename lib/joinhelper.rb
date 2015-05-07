class JoinHelper

  define_singleton_method(:all_authors_books) do
    returned_authors_books = DB.exec('SELECT * FROM authors_books;')
    author_book_pairs = []
    returned_authors_books.each() do |author_book_pair|
      author_id = author_book_pair.fetch('author_id').to_i()
      book_id = author_book_pair.fetch('book_id').to_i()
      author_book_pairs.push({:author_id => author_id, :book_id => book_id})
    end
    return author_book_pairs
  end

  define_singleton_method(:add_author_book_pair) do |author_book|
    author_id = author_book[:author].id()
    book_id = author_book[:book].id()
    DB.exec("INSERT INTO authors_books (author_id, book_id) VALUES (#{author_id}, #{book_id});")
  end

  define_singleton_method(:find_books_by_author_id) do |author_id|
    returned_book_author_pairs = DB.exec("SELECT * FROM authors_books WHERE author_id = #{author_id};")
    books = []
    returned_book_author_pairs.each() do |book_author_pair|
      book_id = book_author_pair.fetch('book_id').to_i()
      books.push(Book.find(book_id))
    end
    return books
  end

  define_singleton_method(:find_authors_by_book_id) do |book_id|
    returned_book_author_pairs = DB.exec("SELECT * FROM authors_books WHERE book_id = #{book_id};")
    authors = []
    returned_book_author_pairs.each() do |book_author_pair|
      author_id = book_author_pair.fetch('author_id').to_i()
      authors.push(Author.find(author_id))
    end
    return authors
  end

  define_singleton_method(:authors_to_s) do |authors|
    authors_array = []
    authors.each() do |author|
      authors_array.push(author.name)
    end
    return authors_array.join(', ')
  end

end
