require "activeresource"

module R3c

class BaseEntity < ActiveResource::Base

  self.format = :json

  def self.set_site(url)
    self.site= url
  end
  
  def self.set_format(format)
    self.format= format
  end
  
  def self.auth(params)
     if params[:api]
       self.api_key(params[:api][:key]) 
    elsif params[:basic_auth]
      self.basic_auth(params[:basic_auth])
    else
     raise "Exception"	   
    end
  end
  
  private 
  def self.api_key(api_key)
    headers['X-Redmine-API-Key'] = api_key
  end
  
   def self.basic_aut(params)
     self.user= params[:user]
     self.password= params[:password] 
   end 

   def self.to_s
      {format: self.format, site: self.site, api_key: self.headers['X-Redmine-API-Key'] , user: self.user, password: self.password}
   end
   
end

class Project<BaseEntity
end

class Issue<BaseEntity
end

class Wiki<BaseEntity
end

class Tracker<BaseEntity
end

class Priority<BaseEntity
end

class CustomField<BaseEntity
end

class User<BaseEntity
end

class Group<BaseEntity
end

class Role<BaseEntity
end

class TimeEntry<BaseEntity
end

class Journal<BaseEntity
end

class Upload<BaseEntity
end

class Attachment<BaseEntity
end
 
end

