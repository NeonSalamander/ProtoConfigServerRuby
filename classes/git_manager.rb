class GitHandler
  #сюда нужно передать инфу о репозитории, сделать класс или хеш
  def initialize(repository)
    @repository = repository
  end

  def call(job, time)
    puts "check #{@repository}"
  end
end
