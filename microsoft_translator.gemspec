# -*- encoding: utf-8 -*-
require File.expand_path('../lib/microsoft_translator/version', __FILE__)

Gem::Specification.new do |gem|
  gem.authors       = ["Christopher Sass"]
  gem.email         = ["chris@lupinedev.com"]
  gem.description   = %q{Ruby library for Microsoft Translate HTTP API}
  gem.summary       = %q{Use Microsoft Translate API in your ruby program}
  gem.homepage      = "https://github.com/ikayzo/microsoft_translator"

  gem.files         = `git ls-files`.split($\)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.name          = "microsoft_translator"
  gem.require_paths = ["lib"]
  gem.version       = MicrosoftTranslator::VERSION
  gem.add_runtime_dependency "rest-client", [">= 1.6.0"]
  gem.add_runtime_dependency "nokogiri", [">= 1.4.0"]
  gem.add_development_dependency "rspec", [">= 2.0.0"]
  gem.add_development_dependency "timecop", [">= 0.3.5"]
end
