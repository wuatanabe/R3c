require "rest-client"


module R3c

  def self.upload(file, format="xml")
    response = RestClient.post("#{R3c::BaseEntity.site}/uploads.#{format}?key=#{R3c::BaseEntity.headers['X-Redmine-API-Key']}", file, {:multipart => true, :content_type => 'application/octet-stream'})
    token = JSON.parse(response)['upload']['token']
  end


#Note: see r3c.rb for example about how to retrieve watchers on an issue 
#Example: 
# R3c.add_watcher(1, 1)
  def self.add_watcher(issue_id, user_id, format="xml")
    #POST /issues/[id]/watchers.[format]
    response = RestClient.post("#{R3c::BaseEntity.site}/issues/#{issue_id}/watchers.#{format}?key=#{R3c::BaseEntity.headers['X-Redmine-API-Key']}", {user_id: user_id})
    return JSON.parse(response) if format == "json"
    response
  end
  
#Example: 
# R3c.remove_watcher(1, 1)
  def self.remove_watcher(issue_id, user_id, format="xml")
   #DELETE /issues/[id]/watchers/[user_id].[format]
    response = RestClient.delete("#{R3c::BaseEntity.site}/issues/#{issue_id}/watchers/#{user_id}.#{format}?key=#{R3c::BaseEntity.headers['X-Redmine-API-Key']}")
    return JSON.parse(response) if format == "json"
    response
  end


  def self.enumerations(enumeration, format="xml")
    #GET /enumerations/<enumeration>.[format]   #enumeration= "issue_priorities" OR  "time_entry_activities"
    response = RestClient.get("#{R3c::BaseEntity.site}/enumerations/#{enumeration}.#{format}?key=#{R3c::BaseEntity.headers['X-Redmine-API-Key']}")   
    return JSON.parse(response) if format == "json"
  end
  
  def self.search(q, format = "xml")
  # GET  '/search.xml', :q => 'recipe subproject commit', :all_words => ''
  response = RestClient.get("#{R3c::BaseEntity.site}/search.#{format}/?key=#{R3c::BaseEntity.headers['X-Redmine-API-Key']}", {all_words: '', q: q})   
  return JSON.parse(response) if format == "json"
  response
  end

end