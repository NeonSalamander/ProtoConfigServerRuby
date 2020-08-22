require 'git'

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

  def initialize(url)
    @url = url
    directory = File.join(Dir.pwd, 'GitRepoLocal/ConfigServer')
    if File.directory?(directory) then
      g = Git.open(directory)
      g.pull('origin', 'master')
      #g = Git.open(directory, :log => Logger.new(STDOUT))
    else
      # g = Git.init
      # g = Git.clone(@url, 'ConfigServer', :path => directory)
    end

  end


end