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


end