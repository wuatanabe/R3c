require 'minitest/autorun'
require 'r3c'

#Assume an new empty redmine installation running on localhost on  port 3000
class R3cTest < Minitest::Test
  
  
   #Connection  
    R3c.site "http://localhost:3000"
    R3c.format :xml
    R3c.auth basic_auth:{user: "admin", password: "password"}


  #Create, Update and Delete a Project
  def test_crud_project
    #create
    @project = R3c.project.new
    @project.name = ('a'..'z').to_a.shuffle.first(8).join #random project name
    @project.identifier=@project.name
    @project.save!
    assert_equal @project.name, R3c.project.find(@project.id).name  
    size= R3c.project.all.size
    #update
    @project.name="replaced"
    @project.save!
    assert_equal "replaced", R3c.project.find(@project.id).name  
    #delete
    R3c.project.delete @project.id
    assert_equal (size-1), R3c.project.all.size
  end

   #Operations on issues
   def test_issues
    #create a project container	   
    @project = R3c.project.new
    @project.name = ('a'..'z').to_a.shuffle.first(8).join #random project name
    @project.identifier=@project.name
    @project.save!   
    #create first issue
    @issue = R3c.issue.new
    @issue.subject="Issue for test"
    @issue.project_id = @project.id
    @issue.save!
    assert 1, R3c.issue.all.size
    #update issue
    @issue.subject="Subject Changed"
    @issue.save!
    assert "Subject Changed", R3c.issue.find(@issue.id).subject
    #delete issue
    R3c.issue.delete @issue.id
    assert 0, R3c.issue.all.size  
   end

  
end