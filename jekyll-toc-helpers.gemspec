lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)

Gem::Specification.new do |spec|
  spec.name          = 'jekyll-toc-helpers'
  spec.version       = '0.1.2'
  spec.authors       = ['Garen Torikian']
  spec.email         = ['gjtorikian@gmail.com']
  spec.summary       = 'Some helper tags for generating TOCs.'
  spec.description   = ''
  spec.homepage      = 'https://github.com/gjtorikian/jekyll-toc-helpers'
  spec.license       = 'MIT'

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test)/})
  spec.require_paths = ['lib']

  spec.add_runtime_dependency 'jekyll', '>= 2.0'

  spec.add_development_dependency 'bundler', '~> 1.3'
  spec.add_development_dependency 'nokogiri', '~> 1.6'
  spec.add_development_dependency 'rake'
  spec.add_development_dependency 'rspec'
end
