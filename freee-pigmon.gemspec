
lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "freee/pigmon/version"

Gem::Specification.new do |spec|
  spec.name          = "freee-pigmon"
  spec.version       = Freee::Pigmon::VERSION
  spec.authors       = ["Iori OSADA"]
  spec.email         = ["iosada@degica.com"]

  spec.summary       = %q{freee checking-in and out system.}
  spec.description   = %q{This is to help you checking-in and out on freee.}
  spec.homepage      = "https://degica.com"
  spec.license       = "MIT"

  # Prevent pushing this gem to RubyGems.org. To allow pushes either set the 'allowed_push_host'
  # to allow pushing to a single host or delete this section to allow pushing to any host.
  if spec.respond_to?(:metadata)
    spec.metadata['allowed_push_host'] = 'https://rubygems.pkg.github.com/degica/freee-pigmon'
  else
    raise "RubyGems 2.0 or newer is required to protect against " \
      "public gem pushes."
  end

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files         = Dir.chdir(File.expand_path('..', __FILE__)) do
    `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.17"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec", "~> 3.0"
  spec.add_development_dependency 'pry-byebug', '~> 3.6.0'

  spec.add_dependency 'oauth2', '~> 1.4.0'
  spec.add_dependency 'faraday', '~> 0.12.2'
  spec.add_dependency 'faraday_middleware', '~> 0.12.2'
  spec.add_dependency 'thor'
end
