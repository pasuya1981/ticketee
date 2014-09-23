require 'rails'

class Project
  attr_accessor :name, :description
  def initialize(name)
  	@name = name
  end
end

@project = Project.new('test')
@project.description = 'some longer test string..'

p 'Project'.constantize do |thing|
  
end
