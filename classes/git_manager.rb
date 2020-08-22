require 'git'

# class GitHandler
#   #сюда нужно передать инфу о репозитории, сделать класс или хеш
#   def initialize(repository)
#     @repository = repository
#   end
#
#   def call(job, time)
#     puts "check #{@repository}"
#   end
# end


class GitRepository

  attr_accessor :url
  attr_reader :last_commit

  def initialize(url)
    @url = url
    work_directory = File.join(Dir.pwd, 'GitRepoLocal')
    repo_directory = "#{work_directory}/ConfigServer"
    if File.directory?(repo_directory) then
      g = Git.open(repo_directory)
      g.pull('origin', 'master')
      #g = Git.open(directory, :log => Logger.new(STDOUT))
    else
       g = Git.init
       g = Git.clone(@url, 'ConfigServer', :path => work_directory)
    end

  end

  def call(job, time)
    puts "check #{@repository}"
  end


end