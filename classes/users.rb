class UsersIterator

  #Добавим примесь что бы класс был итератором со всеми последствиями
  include Enumerable
  #Дадим доступ к чтению/записи коллекции
  attr_accessor :collection
  private :collection

  def initialize(collection)
    @collection = collection
  end

  def each (&block)
    return @collection.each(&block)
  end


end

class Users

  attr_accessor :collection
  private :collection

  def initialize(collection = [])
    @collection = collection
  end

  def iterator
    UsersIterator.new(@collection)
  end

  def add_user(item)
    @collection << item
  end

  def find_by_token(token)
    return @collection.find {|user| user.token = token }
  end

end

class User
  attr_accessor :name, :token

  def initialize(name, token)
    @name = name
    @token = token
  end

end