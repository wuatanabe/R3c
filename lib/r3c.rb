require "r3c/version"
require "r3c/r3c"


module R3c


  
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


#R3c.site('http://localhost:3000/')

#R3c.format(:xml)

#R3c.auth({api: {key: '8091d55257c4c90b6d56e83322622cb5f4ecee64'}})

#puts R3c.time_entry.all.inspect.to_sx 
