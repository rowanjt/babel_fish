Gem::Specification.new do |s|
  s.name        = 'babel_fish'
  s.version     = '0.0.0'
  s.date        = '2016-04-30'
  s.summary     = 'translation interface'
  s.description = 'abstraction of translations for dynamic user entered data'
  s.authors     = ['rowanjt']
  s.email       = ''
  s.files       = ['lib/babel_fish.rb']
  s.homepage    = 'http://rubygems.org/gems/babel_fish'
  s.license     = 'MIT'
  s.add_runtime_dependency 'activesupport', ['4.2.5.1']
  s.add_development_dependency 'minitest-colorize', ['0.0.5']
  s.add_development_dependency 'pry', ['0.9.12.4']
end