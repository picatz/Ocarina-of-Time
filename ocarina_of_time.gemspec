# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'ocarina_of_time/version'

Gem::Specification.new do |spec|
  spec.name          = "ocarina_of_time"
  spec.version       = OcarinaOfTime::VERSION
  spec.authors       = ["Kent Gruber"]
  spec.email         = ["kgruber1@emich.edu"]

  spec.summary       = %q{The Ocarina of Time is a ruby gem to manage timelines.}
  spec.description   = %q{The Ocarina of Time is a ruby gem to manage timelines through a simple API to contrsuct timelines and manage the events that happen during the liftime of a timeline.}
  spec.homepage      = "https://github.com/picatz/Ocarina-of-Time"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end
  spec.bindir        = "bin"
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.14"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec", "~> 3.0"
end
