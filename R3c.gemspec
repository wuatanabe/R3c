$LOAD_PATH.unshift 'lib'
require "r3c/version"

Gem::Specification.new do |s|
  s.name              = "R3c"
  s.version           = R3c::VERSION
  s.date              = Time.now.strftime('%Y-%m-%d')
  s.summary           = "Rest Redmine Ruby Client"
  s.homepage          = "http://github.com//R3c"
  s.email             = "paolo.freuli@gmail.com"
  s.licenses	= ['MIT']
  s.authors           = [ "Paolo Freuli" ]
  s.has_rdoc          = false

  s.files             = %w( README.md LICENSE )
  s.files            += Dir.glob("lib/**/*")
  s.files            += Dir.glob("bin/**/*")
  s.files            += Dir.glob("test/**/*")

#  s.executables       = %w( R3c )

  s.add_runtime_dependency 'activeresource', '~> 4.1', '>= 4.1.0'
  s.add_runtime_dependency 'rest-client',    '~> 2.0.0', '>= 2.0.0'
  s.add_runtime_dependency 'json',      '~> 1.8.3', '>= 1.8.3'

  
  s.description       = <<desc
  Redmine Rest Client writte in Ruby.
desc
end
