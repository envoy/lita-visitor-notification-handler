Gem::Specification.new do |spec|
  spec.name          = "lita-visitor-notification-handler"
  spec.version       = "0.0.2"
  spec.authors       = ["Victor Lin"]
  spec.email         = ["victor@signwithenvoy.com"]
  spec.summary       = "Lita handler for parsing Envoy visitor notification message"
  spec.homepage      = "https://github.com/envoy/lita-visitor-notification-handler"
  spec.license       = "MIT"
  spec.metadata      = { "lita_plugin_type" => "handler" }

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_runtime_dependency "lita", ">= 4.3"
  spec.add_runtime_dependency "httparty"

  spec.add_development_dependency "bundler", "~> 1.3"
  spec.add_development_dependency "pry-byebug"
  spec.add_development_dependency "rake"
  spec.add_development_dependency "rack-test"
  spec.add_development_dependency "rspec", ">= 3.0.0"
end
