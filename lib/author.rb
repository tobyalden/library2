class Author

  attr_reader(:name, :id)

  define_method(:initialize) do |attributes|
    @name = attributes[:name]
    @id = attributes[:id]
  end

  define_method(:==) do |other_author|
    return @name == other_author.name()
  end

  define_method(:save) do
    result = DB.exec("INSERT INTO authors (name) VALUES ('#{@name}') RETURNING id;")
    @id = result.first().fetch('id').to_i()
  end

  define_method(:delete) do
    DB.exec("DELETE FROM authors WHERE id = #{@id};")
  end

  define_singleton_method(:all) do
    returned_authors = DB.exec('SELECT * FROM authors;')
    authors = []
    returned_authors.each() do |author|
      name = author.fetch('name')
      id = author.fetch('id').to_i()
      authors.push(Author.new({:name => name, :id => id}))
    end
    authors
  end

  define_singleton_method(:find) do |search_id|
    returned_author = DB.exec("SELECT * FROM authors WHERE id = #{search_id};")
    if !returned_author.values().empty?()
      name = returned_author.first().fetch('name')
      id = returned_author.first().fetch('id').to_i()
      return Author.new({:name => name, :id => id})
    end
    return nil
  end

end
