$: << File.expand_path("lib")

Gem::Specification.new do |s|
  s.name        = "yaml-schema"
  s.version     = "1.0.0"
  s.summary     = "Write ARM64 assembly in Ruby!"
  s.description = "Tired of writing Ruby in Ruby? Now you can write ARM64 assembly in Ruby!"
  s.authors     = ["Aaron Patterson"]
  s.email       = "tenderlove@ruby-lang.org"
  s.files       = `git ls-files -z`.split("\x0")
  s.test_files  = s.files.grep(%r{^test/})
  s.homepage    = "https://github.com/tenderlove/yaml-schema"
  s.license     = "Apache-2.0"
end
