require "rest-client"


module R3c




  def self.upload(file)
    response = nil
    params= {:multipart => true, :content_type => 'application/octet-stream'}
    params= set_ssl_params(params)
    if !R3c::BaseEntity.user
      #response = RestClient.post("#{R3c::BaseEntity.site}/uploads.json?key=#{R3c::BaseEntity.headers['X-Redmine-API-Key']}", file, {:multipart => true, :content_type => 'application/octet-stream'})
       response = RestClient.post("#{R3c::BaseEntity.site}/uploads.json?key=#{R3c::BaseEntity.headers['X-Redmine-API-Key']}", file, params)
    else
      params = add_auth(params)	    
      response = RestClient.post("#{R3c::BaseEntity.site}/uploads.json", file, params)
    end
      JSON.parse(response)['upload']['token'] 
  end




#Note: see r3c.rb for example about how to retrieve watchers on an issue 
#Example: 
# R3c.add_watcher(1, 1)
  def self.add_watcher(issue_id, user_id, format="xml")
    #POST /issues/[id]/watchers.[format]
    response = execute(method: :post, url: "#{R3c::BaseEntity.site}/issues/#{issue_id}/watchers.#{format}", headers: {params: {user_id: user_id}})
    return JSON.parse(response) if format == "json"
    response
  end
  
#Example: 
# R3c.remove_watcher(1, 1)
  def self.remove_watcher(issue_id, user_id, format="xml")
   #DELETE /issues/[id]/watchers/[user_id].[format]
    response =  execute(method: :delete, url: "#{R3c::BaseEntity.site}/issues/#{issue_id}/watchers/#{user_id}.#{format}")
    return JSON.parse(response) if format == "json"
    response
  end

  #Example:
  # R3c.enumerations("issue_priorities")  
  def self.enumerations(enumeration, format="xml")
    #GET /enumerations/<enumeration>.[format]   #enumeration= "issue_priorities" OR  "time_entry_activities"
    response =  self.execute(method: :get, url: "#{R3c::BaseEntity.site}/enumerations/#{enumeration}.#{format}")   
    return JSON.parse(response) if format == "json"
    response
  end
  
  #Example:
  # R3c.relations(issue_id)  
  def self.relations(issue_id)
    response =  self.execute(method: :get, url: "#{R3c::BaseEntity.site}/issues/#{issue.id}/relations.#{format}")   
    return JSON.parse(response) if format == "json"
    response
  end 

   def self.add_relation(issue_id, issue_to_id, relation_type, delay=nil)
    response =  self.execute(method: :post, url: "#{R3c::BaseEntity.site}/issues/#{issue.id}/relations.#{format}", headers: {params: {issue_to_id: issue_to_id, relation_type: relation_type, delay: delay}})   
    return JSON.parse(response) if format == "json"
    response
   end
   
   def self.get_relation(relation_id)
    response =  self.execute(method: :get, url: "#{R3c::BaseEntity.site}/relations/#{relation_id}.#{format}")   
    return JSON.parse(response) if format == "json"
    response
   end
   
   def self.delete(relation_id)
    response =  self.execute(method: :delete, url: "#{R3c::BaseEntity.site}/relations/#{relation_id}.#{format}")   
    return JSON.parse(response) if format == "json"
    response
   end
  
  #Example:
  # R3c.search("sometext")  
  def self.search(q, format = "json")
  # GET  '/search.xml', :q => 'recipe subproject commit', :all_words => ''
  response = execute(method: :get, url: "#{R3c::BaseEntity.site}/search.#{format}",  headers: {params: {all_words: "", q: q}} )  
  return JSON.parse(response)# if format == "json"
  response
  end

 private
  def self.execute(params)
   params = add_auth(params)
   params= set_ssl_params(params)
   puts "rest-helper.rb->execute: params="+params.inspect.to_s
   RestClient::Request.execute(params)
  end
  
  def self.add_auth(params)
   if R3c::BaseEntity.user
     params[:user]= R3c::BaseEntity.user
     params[:password]=R3c::BaseEntity.password
   else
     params[:url]= params[:url]+"?key=#{R3c::BaseEntity.headers['X-Redmine-API-Key']}"
   end
    return params
  end

  def self.set_ssl_params(params)
   if R3c::BaseEntity.site.to_s.include?("https") 
     params[:verify_ssl]=R3c::BaseEntity.ssl_options[:verify_mode]
     params= params.merge(R3c::BaseEntity.ssl_options)
   end
    return params
  end


end