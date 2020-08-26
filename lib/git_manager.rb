# frozen_string_literal: true
require 'git'

class GitRepository

  attr_accessor :url
  attr_reader :last_commit, :git

  def initialize(url)
    @url = url
    @work_directory = File.join(Dir.pwd, 'GitRepoLocal')
    @repo_directory = "#{@work_directory}/ConfigServer"

    if File.directory?(@repo_directory) then
      @git = Git.open(@repo_directory)
      @git.pull('origin', 'master')
    else
      @git = Git.init
      @git = Git.clone(@url, 'ConfigServer', :path => @work_directory)
    end
  end

  def call(job, time)
    self.git.pull('origin', 'master')
  end

  def get_config(application_name)
    file_name = Dir["#{@repo_directory}/#{application_name}*"].first
    file = File.open(file_name, "r")
    res = file.read
    file.close
    res
  end

end