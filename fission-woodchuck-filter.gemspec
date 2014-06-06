$LOAD_PATH.unshift File.expand_path(File.dirname(__FILE__)) + '/lib/'
require 'fission-woodchuck-filter/version'
Gem::Specification.new do |s|
  s.name = 'fission-woodchuck-filter'
  s.version = Fission::WoodchuckFilter::VERSION.version
  s.summary = 'Fission Log Entry Filter'
  s.author = 'Heavywater'
  s.email = 'fission@hw-ops.com'
  s.homepage = 'http://github.com/heavywater/fission-woodchuck-filter'
  s.description = 'Fission Log Entry Filter'
  s.require_path = 'lib'
  s.add_dependency 'fission'
  s.files = Dir['**/*']
end
