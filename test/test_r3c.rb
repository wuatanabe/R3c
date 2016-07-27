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
    @project= create_project
    assert_equal @project.name, R3c.project.find(@project.id).name  
    size= R3c.project.all.size
    #update
    @project.name="replaced"
    @project.save!
    assert_equal "replaced", R3c.project.find(@project.id).name  
    #delete
    delete_project(@project.id)
    assert_equal (size-1), R3c.project.all.size
  end

   #Operations on issues
   def test_issues
    #create a project container	   
    @project= create_project
    #create first issue
    @issue = R3c.issue.new
    @issue.subject="Issue for test"
    @issue.project_id = @project.id
    @issue.save!
    assert 1, R3c.issue.all.size
    #update issue
    @issue.subject="Subject Changed"
    @issue.save!
    assert_equal "Subject Changed", R3c.issue.find(@issue.id).subject
    #attach file to issue
     file = File.read('c:\windows-version.txt')
     token = R3c.upload file
     random_string=('a'..'z').to_a.shuffle.first(8).join 
     issue_params= {"project_id"=> 1, "subject"=> "This is the subject #{random_string}"}
     issue_params["uploads"]= [{"upload"=>{"token"=> token, "filename"=> "R3c.gemspec", "description"=> "a gemspec", "content_type"=> "text/plain"}}]
     @issue= R3c.issue.create(issue_params)
     @issue= R3c.issue.find(@issue.id, params: {include: "attachments"})
     assert_equal "R3c.gemspec", @issue.attachments.first.filename
    #add a note to issue
    #TBD
    #add wathcher to issue
    R3c.add_watcher(@issue.id, 1)
    @issue= R3c.issue.find(@issue.id, params: {include: "watchers"})
    assert_equal 1, @issue.watchers.size
    #remove watcher from issue
    R3c.remove_watcher(@issue.id, 1)
    @issue= R3c.issue.find(@issue.id, params: {include: "watchers"})
    assert_equal 0, @issue.watchers.size
    #search a string in issues (will search also in wiki)
    results= R3c.search(random_string)
    assert_equal 1, results["results"].size
    #delete issue
    R3c.issue.delete @issue.id
    assert 0, R3c.issue.all.size
    #clean up project
    delete_project(@project.id)
   end
   
   
   def test_user
   #create_projenct
   project= create_project
   #get user
     user= R3c.user.find 1
     puts "user=#{user.inspect.to_s}"
     assert_equal  "admin", user.login
   #all user
     user_size= R3c.user.all.size
   #create user
     user = R3c.user.new
     user.firstname="new"
     user.lastname="user"
     user.login="new.user"
     user.password="new.password"
     user.password_confirmation= "new.password"
     user.mail="new.user@r3c.it"
	
    if user.save
    else
      puts user.errors.inspect.to_s
    end
   #create group
   #TBD
   #create project membership  
   #delete user
     R3c.user.delete user.id   
     assert_equal user_size, R3c.user.all.size
   #delete project
     R3c.project.delete project.id
   end

  
  #TBD
  def test_wiki
  end

  #TBD
  def test_issue_custom_fields
  end
  
  #TBD
  def test_other_stuff
  end

  private
    def create_project
      @project = R3c.project.new
      @project.name = ('a'..'z').to_a.shuffle.first(8).join #random project name
      @project.identifier=@project.name
      @project.save!
      @project
    end
    
    def delete_project(id)
          R3c.project.delete id
    end
end