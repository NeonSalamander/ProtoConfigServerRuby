class GitHandler
  #сюда нужно передать инфу о репозитории, сделать класс или хеш
  def initialize(repository)
    @repository = repository
  end

  def call(job, time)
    puts "check #{@repository}"
  end
end


class GitRepository

  attr_accessor :url
  attr_reader :last_commit

  def initialize
    super
  end


end