$LOAD_PATH.unshift 'lib'
require "r3c/version"

Gem::Specification.new do |s|
  s.name              = "R3c"
  s.version           = R3c::VERSION
  s.date              = Time.now.strftime('%Y-%m-%d')
  s.summary           = "Rest Redmine Ruby Client"
  s.homepage          = "http://github.com//R3c"
  s.email             = "paolo.freuli@gmail.com"
  s.authors           = [ "Paolo Freuli" ]
  s.has_rdoc          = false

  s.files             = %w( README.md LICENSE )
  s.files            += Dir.glob("lib/**/*")
  s.files            += Dir.glob("bin/**/*")
  s.files            += Dir.glob("test/**/*")

#  s.executables       = %w( R3c )
  s.description       = <<desc
  Feed me.
desc
end
