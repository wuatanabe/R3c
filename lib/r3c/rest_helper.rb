require "rest-client"


module R3c

  def self.upload(file)
    response = RestClient.post("#{R3c::BaseEntity.site}/uploads.json?key=#{R3c::BaseEntity.headers['X-Redmine-API-Key']}", file, {:multipart => true, :content_type => 'application/octet-stream'})
    token = JSON.parse(response)['upload']['token']
  end


#Note: see r3c.rb for example about how to retrieve watchers on an issue 
#Example: 
# R3c.add_watcher(1, 1)
  def self.add_watcher(issue_id, user_id)
    #POST /issues/[id]/watchers.[format]
    response = RestClient.post("#{R3c::BaseEntity.site}/issues/#{issue_id}/watchers.xml?key=#{R3c::BaseEntity.headers['X-Redmine-API-Key']}", {user_id: user_id})
  end
  
#Example: 
# R3c.remove_watcher(1, 1)
  def self.remove_watcher(issue_id, user_id)
   #DELETE /issues/[id]/watchers/[user_id].[format]
    response = RestClient.delete("#{R3c::BaseEntity.site}/issues/#{issue_id}/watchers/#{user_id}.xml?key=#{R3c::BaseEntity.headers['X-Redmine-API-Key']}")
  end


  def self.enumerationsì(enumeration, format: "xml")
    #GET /enumerations/<enumeration>.[format]   #enumeration= "issue_priorities" OR  "time_entry_activities"
    response = RestClient.post("#{R3c::BaseEntity.site}/enumerations/#{enumeration}.#{format}?key=#{R3c::BaseEntity.headers['X-Redmine-API-Key']}")   
  end
  
  
end