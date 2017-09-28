# -*- encoding: utf-8 -*-
# stub: open-weather 0.12.0 ruby lib

Gem::Specification.new do |s|
  s.name = "open-weather".freeze
  s.version = "0.12.0"

  s.required_rubygems_version = Gem::Requirement.new(">= 0".freeze) if s.respond_to? :required_rubygems_version=
  s.require_paths = ["lib".freeze]
  s.authors = ["HsPS mailme@hsps.in".freeze, "Deepak deepakkumarnd@gmail.com".freeze]
  s.date = "2016-06-04"
  s.description = " A ruby wrapper for Open Weather Map API. ".freeze
  s.email = ["mailme@hsps.in".freeze]
  s.homepage = "https://github.com/coderhs/ruby_open_weather_map".freeze
  s.licenses = ["MIT".freeze]
  s.rubygems_version = "2.5.2".freeze
  s.summary = "A ruby wrapper for Open Weather Map API.".freeze

  s.installed_by_version = "2.5.2" if s.respond_to? :installed_by_version

  if s.respond_to? :specification_version then
    s.specification_version = 4

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_development_dependency(%q<rspec>.freeze, [">= 2.13.0", "~> 2.13"])
      s.add_development_dependency(%q<vcr>.freeze, [">= 2.9.2", "~> 2.9"])
      s.add_development_dependency(%q<webmock>.freeze, [">= 1.18.0", "~> 1.18"])
      s.add_runtime_dependency(%q<json>.freeze, ["~> 1"])
    else
      s.add_dependency(%q<rspec>.freeze, [">= 2.13.0", "~> 2.13"])
      s.add_dependency(%q<vcr>.freeze, [">= 2.9.2", "~> 2.9"])
      s.add_dependency(%q<webmock>.freeze, [">= 1.18.0", "~> 1.18"])
      s.add_dependency(%q<json>.freeze, ["~> 1"])
    end
  else
    s.add_dependency(%q<rspec>.freeze, [">= 2.13.0", "~> 2.13"])
    s.add_dependency(%q<vcr>.freeze, [">= 2.9.2", "~> 2.9"])
    s.add_dependency(%q<webmock>.freeze, [">= 1.18.0", "~> 1.18"])
    s.add_dependency(%q<json>.freeze, ["~> 1"])
  end
end
