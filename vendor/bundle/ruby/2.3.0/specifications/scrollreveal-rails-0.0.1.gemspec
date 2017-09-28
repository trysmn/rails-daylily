# -*- encoding: utf-8 -*-
# stub: scrollreveal-rails 0.0.1 ruby lib

Gem::Specification.new do |s|
  s.name = "scrollreveal-rails".freeze
  s.version = "0.0.1"

  s.required_rubygems_version = Gem::Requirement.new(">= 0".freeze) if s.respond_to? :required_rubygems_version=
  s.require_paths = ["lib".freeze]
  s.authors = ["Ankit Gupta".freeze, " Ekta Verma".freeze]
  s.date = "2014-02-23"
  s.description = "Gem that includes ScrollReveal (A small library to create and maintain how elements fade in,triggered when they enter the viewport.)".freeze
  s.email = ["ankit.gupta8898@gmail.com".freeze, "eku4evr@gmail.com".freeze]
  s.homepage = "https://github.com/gemathon-rockets/scrollreveal-rails".freeze
  s.licenses = ["MIT".freeze]
  s.rubygems_version = "2.5.2".freeze
  s.summary = "Ruby Wrapper on top of ScrollReveal.js".freeze

  s.installed_by_version = "2.5.2" if s.respond_to? :installed_by_version

  if s.respond_to? :specification_version then
    s.specification_version = 4

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<railties>.freeze, [">= 3.1"])
      s.add_development_dependency(%q<bundler>.freeze, ["~> 1.0"])
      s.add_development_dependency(%q<rails>.freeze, [">= 3.1"])
      s.add_development_dependency(%q<rake>.freeze, [">= 0"])
    else
      s.add_dependency(%q<railties>.freeze, [">= 3.1"])
      s.add_dependency(%q<bundler>.freeze, ["~> 1.0"])
      s.add_dependency(%q<rails>.freeze, [">= 3.1"])
      s.add_dependency(%q<rake>.freeze, [">= 0"])
    end
  else
    s.add_dependency(%q<railties>.freeze, [">= 3.1"])
    s.add_dependency(%q<bundler>.freeze, ["~> 1.0"])
    s.add_dependency(%q<rails>.freeze, [">= 3.1"])
    s.add_dependency(%q<rake>.freeze, [">= 0"])
  end
end
