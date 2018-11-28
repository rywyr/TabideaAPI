# -*- encoding: utf-8 -*-
# stub: bitly 1.1.2 ruby lib

Gem::Specification.new do |s|
  s.name = "bitly".freeze
  s.version = "1.1.2"

  s.required_rubygems_version = Gem::Requirement.new(">= 0".freeze) if s.respond_to? :required_rubygems_version=
  s.require_paths = ["lib".freeze]
  s.authors = ["Phil Nash".freeze]
  s.date = "2018-08-19"
  s.description = "Use the bit.ly API to shorten or expand URLs".freeze
  s.email = "philnash@gmail.com".freeze
  s.extra_rdoc_files = ["LICENSE.md".freeze, "README.md".freeze]
  s.files = ["LICENSE.md".freeze, "README.md".freeze]
  s.homepage = "http://github.com/philnash/bitly".freeze
  s.licenses = ["MIT".freeze]
  s.rdoc_options = ["--line-numbers".freeze, "--title".freeze, "Bitly".freeze, "--main".freeze, "README.md".freeze]
  s.required_ruby_version = Gem::Requirement.new(">= 1.8.7".freeze)
  s.rubygems_version = "2.7.6".freeze
  s.summary = "Use the bit.ly API to shorten or expand URLs".freeze

  s.installed_by_version = "2.7.6" if s.respond_to? :installed_by_version

  if s.respond_to? :specification_version then
    s.specification_version = 4

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<multi_json>.freeze, ["~> 1.3"])
      s.add_runtime_dependency(%q<httparty>.freeze, [">= 0.7.6"])
      s.add_runtime_dependency(%q<oauth2>.freeze, ["< 2.0", ">= 0.5.0"])
      s.add_development_dependency(%q<bundler>.freeze, ["~> 1.15"])
      s.add_development_dependency(%q<rake>.freeze, [">= 0"])
      s.add_development_dependency(%q<shoulda>.freeze, ["~> 3.5.0"])
      s.add_development_dependency(%q<flexmock>.freeze, [">= 0"])
      s.add_development_dependency(%q<webmock>.freeze, [">= 0"])
      s.add_development_dependency(%q<minitest>.freeze, ["~> 5.8.3"])
    else
      s.add_dependency(%q<multi_json>.freeze, ["~> 1.3"])
      s.add_dependency(%q<httparty>.freeze, [">= 0.7.6"])
      s.add_dependency(%q<oauth2>.freeze, ["< 2.0", ">= 0.5.0"])
      s.add_dependency(%q<bundler>.freeze, ["~> 1.15"])
      s.add_dependency(%q<rake>.freeze, [">= 0"])
      s.add_dependency(%q<shoulda>.freeze, ["~> 3.5.0"])
      s.add_dependency(%q<flexmock>.freeze, [">= 0"])
      s.add_dependency(%q<webmock>.freeze, [">= 0"])
      s.add_dependency(%q<minitest>.freeze, ["~> 5.8.3"])
    end
  else
    s.add_dependency(%q<multi_json>.freeze, ["~> 1.3"])
    s.add_dependency(%q<httparty>.freeze, [">= 0.7.6"])
    s.add_dependency(%q<oauth2>.freeze, ["< 2.0", ">= 0.5.0"])
    s.add_dependency(%q<bundler>.freeze, ["~> 1.15"])
    s.add_dependency(%q<rake>.freeze, [">= 0"])
    s.add_dependency(%q<shoulda>.freeze, ["~> 3.5.0"])
    s.add_dependency(%q<flexmock>.freeze, [">= 0"])
    s.add_dependency(%q<webmock>.freeze, [">= 0"])
    s.add_dependency(%q<minitest>.freeze, ["~> 5.8.3"])
  end
end
