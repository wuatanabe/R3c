require "rest-client"


module R3c




  def self.upload(file, format="xml")
    response = execute(method: :post, url: "#{R3c::BaseEntity.site}/uploads.#{format}", file: file, :multipart => true, :content_type => 'application/octet-stream')
    token = JSON.parse(response)['upload']['token']
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
  # R3c.search("sometext")  
  def self.search(q, format = "xml")
  # GET  '/search.xml', :q => 'recipe subproject commit', :all_words => ''
  response = execute(method: :get, url: "#{R3c::BaseEntity.site}/search.#{format}",  headers: {params: {all_words: "", q: q}} )  
  return JSON.parse(response) if format == "json"
  response
  end

 private
  def self.execute(params)
   if R3c::BaseEntity.user
     params[:user]= R3c::BaseEntity.user
     params[:password]=R3c::BaseEntity.password
   else
     params[:url]= params[:url]+"?key=#{R3c::BaseEntity.headers['X-Redmine-API-Key']}"
   end
   puts "rest-helper.rb->execute: params="+params.inspect.to_s
   if R3c::BaseEntity.site.to_s.include?("https") 
     params[:verify_ssl]=R3c::BaseEntity.ssl_options[:verify_mode]
     params= params.merge(R3c::BaseEntity.ssl_options)
     puts "rest-helper.rb->execute: params="+params.inspect.to_s
   end
   RestClient::Request.execute(params)
  end

end