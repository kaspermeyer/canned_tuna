lib = File.expand_path("lib", __dir__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "canned_tuna/version"

Gem::Specification.new do |spec|
  spec.name = "canned_tuna"
  spec.version = CannedTuna::VERSION
  spec.authors = ["Kasper Meyer"]
  spec.email = ["hi@kaspermeyer.com"]

  spec.summary = "Components for Prawn"
  spec.description = "Modular components to encapsulate data and markup in Prawn"
  spec.homepage = "https://github.com/kaspermeyer/canned_tuna"
  spec.license = "MIT"

  spec.metadata["homepage_uri"] = spec.homepage
  spec.metadata["source_code_uri"] = spec.homepage

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files = Dir.chdir(File.expand_path("..", __FILE__)) do
    `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  end
  spec.bindir = "exe"
  spec.executables = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_dependency "prawn", "~> 2.2"
  spec.add_development_dependency "bundler", "~> 2.0"
  spec.add_development_dependency "minitest", "~> 5.0"
  spec.add_development_dependency "minitest-focus", "~> 1.2"
  spec.add_development_dependency "pdf-inspector", "~> 1.3"
  spec.add_development_dependency "rake", "~> 13.0"
  spec.add_development_dependency "standard", "~> 0.1.4"
end
