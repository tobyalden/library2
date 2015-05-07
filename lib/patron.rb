class Patron

  attr_reader(:name, :id)

  define_method(:initialize) do |attributes|
    @name = attributes[:name]
    @id = attributes[:id]
  end

  define_method(:==) do |other_patron|
    return @name == other_patron.name()
  end

  define_method(:save) do
    result = DB.exec("INSERT INTO patrons (name) VALUES ('#{@name}') RETURNING id;")
    @id = result.first().fetch('id').to_i()
  end

  define_method(:delete) do
    DB.exec("DELETE FROM patrons WHERE id = #{@id};")
  end

  define_singleton_method(:all) do
    returned_patrons = DB.exec('SELECT * FROM patrons;')
    patrons = []
    returned_patrons.each() do |patron|
      name = patron.fetch('name')
      id = patron.fetch('id').to_i()
      patrons.push(Patron.new({:name => name, :id => id}))
    end
    patrons
  end

  define_singleton_method(:find) do |search_id|
    returned_patron = DB.exec("SELECT * FROM patrons WHERE id = #{search_id};")
    if !returned_patron.values().empty?()
      name = returned_patron.first().fetch('name')
      id = returned_patron.first().fetch('id').to_i()
      return Patron.new({:name => name, :id => id})
    end
    return nil
  end

  define_singleton_method(:get_id_by_name) do |patron_name|
    returned_patron_id = DB.exec("SELECT id FROM patrons WHERE name = '#{patron_name}';")
    if !returned_patron_id.values().empty?()
      return returned_patron_id.first().fetch('id').to_i()
    end
    return nil
  end

end
