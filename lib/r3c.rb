require "r3c/r3c"
require "r3c/version"


module R3c


def self.upload(file)
  require "rest_client"
  require "json"
  response = RestClient.post("#{R3c::BaseEntity.site}/uploads.json?key=#{R3c::BaseEntity.headers['X-Redmine-API-Key']}", file, {:multipart => true, :content_type => 'application/octet-stream'})
  puts response.inspect.to_s
  token = JSON.parse(response)['upload']['token']
end

  
 def self.version
    VERSION
 end

 def self.site site
  R3c::BaseEntity.set_site(site)
 end

 def self.format format
  R3c::BaseEntity.set_format(format)
 end
 
  def self.auth auth
    R3c::BaseEntity.auth auth
 end

 
 private
 
 def self.method_missing(m, *args, &block)
    puts "Called method #{m} on R3c"
    ref_class="R3c::#{self.camelize(m)}"
    Object.const_get(ref_class)
 end
 
 def self.camelize(m)
   m.to_s.split('_').collect(&:capitalize).join
 end

end


#~ R3c.site('http://localhost:3000/')
#~ R3c.format(:xml)

#~ R3c.auth({api: {key: '8091d55257c4c90b6d56e83322622cb5f4ecee64'}})

#~ file = File.read('c:\windows-version.txt')
#~ puts file.inspect.to_s
#~ token = R3c.upload file
#~ puts token

#~ issue_params= {"project_id"=> 1, "subject"=> "This is the subject"}

#~ issue_params["uploads"]= [{"upload"=>{"token"=> token, "filename"=> "R3c.gemspec", "description"=> "a gemspec", "content_type"=> "text/plain"}}]
#~ issue= R3c.issue.create(issue_params )
		
