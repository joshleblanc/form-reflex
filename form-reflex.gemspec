$:.push File.expand_path("lib", __dir__)

# Maintain your gem's version:
require "form/reflex/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |spec|
  spec.name        = "form-reflex"
  spec.version     = Form::Reflex::VERSION
  spec.authors     = ["Joshua LeBlanc"]
  spec.email       = ["jleblanc@hey.com"]
  spec.homepage    = "https://github.com/joshleblanc/form-reflex"
  spec.summary     = "A library reflex to provide realtime form validation using the validations you already have"
  spec.description = "A library reflex to provide realtime form validation using the validations you already have"
  spec.license     = "MIT"

  # Prevent pushing this gem to RubyGems.org. To allow pushes either set the 'allowed_push_host'
  # to allow pushing to a single host or delete this section to allow pushing to any host.4
  if spec.respond_to?(:metadata)
    spec.metadata["allowed_push_host"] = "https://rubygems.org"
  else
    raise "RubyGems 2.0 or newer is required to protect against " \
      "public gem pushes."
  end

  spec.files = Dir["{app,lib}/**/*", "MIT-LICENSE", "Rakefile", "README.md"]

  spec.add_dependency "rails", "~> 6.0.3", ">= 6.0.3.2"
  spec.add_dependency "optimism"
  spec.add_dependency "stimulus_reflex"

  spec.add_development_dependency "sqlite3"
end
