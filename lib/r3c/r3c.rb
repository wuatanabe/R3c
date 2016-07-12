require "activeresource"


module R3c

class BaseEntity < ActiveResource::Base

  self.format = :xml

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
    self.headers['X-Redmine-API-Key'] = api_key
  end
  
   def self.basic_aut(params)
     self.user= params[:user]
     self.password= params[:password] 
   end 

   def self.to_s
      {format: self.format, site: self.site, api_key: self.headers['X-Redmine-API-Key'] , user: self.user, password: self.password}
   end
   
end

# CRUD on Version
# Example: R3c.project.find(1).get(:versions)
class Version<BaseEntity
end

# CRUD on Membership
# Example: Get memberships: R3c.project.find(1).get(:memberships)
# Example: Create a membership: R3c.wiki_page.new
class Membership<BaseEntity
  #self.prefix "/projects/editing_item"
  #self.element_name ""
end

# List wiki on a project
# R3c.project.find(1).get("wiki/index")

# Get a wiki page by name
# R3c.project.find(1).get("wiki")

# Create  a WikiPage
# R3c.wiki_page.new
class WikiPage<BaseEntity
  #self.prefix "/projects/editing_item"
  #self.element_name ""
end


# CRUD on Project
# Call R3c.project.*
# Example: R3c.project.find 1
class Project<BaseEntity
end


# CRUD on Issue
# Call R3c.issue.*
# Example: R3c.issue.find 1
class Issue<BaseEntity
end



# Call R3c.tracker.all
class Tracker<BaseEntity
end

# CRUD on CustomField
# Call R3c.custom_field.find(id)
# Example: R3c.custom_field.find 1
class CustomField<BaseEntity
end

# CRUD on User
# Call R3c.user.*
# Example: R3c.user.find 1
class User<BaseEntity
end

# Call R3c.group.all
class Group<BaseEntity
end

# Call R3c.issue_status.all
class IssueStatus<BaseEntity
end

# CRUD on Group
# Call R3c.group.*
# Example: R3c.group.find 1
class Role<BaseEntity
end

# CRUD on TimeEntry
# Call R3c.time_entry.*
# Example: R3c.time_entry.first
# Example:  R3c.project.find(1).time_entries
class TimeEntry<BaseEntity
end


# CRUD on Attachment
# Call R3c.attachment.find(id)
# Example: R3c.attachment.find 1
class Attachment<BaseEntity
end

# CRUD on Query
# Call R3c.query.find(id)
# Example: R3c.query.find 1
 class Query<BaseEntity
end
 
end

