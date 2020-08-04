Gem::Specification.new do |spec|
  spec.name        = 'puppet-lint-contained_classes-check'
  spec.version     = '1.0.0'
  spec.homepage    = 'https://github.com/dadav/puppet-lint-contained_classes-check'
  spec.license     = 'APACHE2.0'
  spec.author      = 'dadav'
  spec.email       = '33197631+dadav@users.noreply.github.com'
  spec.files       = Dir[
    'README.md',
    'LICENSE',
    'lib/**/*',
    'spec/**/*',
  ]
  spec.test_files  = Dir['spec/**/*']
  spec.summary     = 'A plugin that checks if every class resource is contained.'
  spec.description = <<-EOF
    If the class resource is used, it also should be contained.
  EOF

  spec.add_dependency             'puppet-lint', '~> 1.0'
  spec.add_development_dependency 'rspec', '~> 3.0'
  spec.add_development_dependency 'rspec-its', '~> 1.0'
  spec.add_development_dependency 'rspec-collection_matchers', '~> 1.0'
  spec.add_development_dependency 'rake'
end
