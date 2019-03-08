
lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "rspec/repetitive/version"

Gem::Specification.new do |spec|
  spec.name          = "rspec-repetitive"
  spec.version       = RSpec::Repetitive::VERSION
  spec.authors       = ["Jamie English"]
  spec.email         = ["jamienglish@gmail.com"]

  spec.summary       = %q{Repeat RSpec examples with custom setup.}
  spec.description   = %q{Repeat RSpec examples with custom setup.}
  spec.homepage      = "https://github.com/english/rspec-repetitive"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_dependency "rspec-core", "~> 3.0"

  spec.add_development_dependency "rspec", "~> 3.0"
end
