class Message
  
  def self.all(project_id)
    project = Project.load(project_id)
    all = project.messages(:all)
  end
  
end