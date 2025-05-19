# Bibliothecary

Dependency manifest parsing library for https://github.com/khulnasoft-lab 

This is a maintained fork of the original [Bibliothecary](https://github.com/librariesio/bibliothecary) gem, with support for additional manifest formats and bug fixes.

[![license](https://img.shields.io/github/license/khulnasoft-lab/bibliothecary.svg)](https://github.com/khulnasoft-lab/bibliothecary/blob/master/LICENSE.txt)

## Installation

Requires Ruby 3.0 or above.

Add this line to your application's Gemfile:

```ruby
gem "bibliothecary", git: "https://github.com/khulnasoft-lab/bibliothecary.git"
```

And then execute:

    $ bundle install

## Usage

Identify package manager manifests from a list of files:

```ruby
Bibliothecary.identify_manifests(['package.json', 'README.md', 'index.js']) #=> 'package.json'
```

Parse a manifest file for it's dependencies:

```ruby
Bibliothecary.analyse_file 'bower.json', File.open('bower.json').read
```

Search a directory for manifest files and parse the contents:

```ruby
Bibliothecary.analyse('./')
```

There are a number of parsers that rely on web services to parse the file formats, those urls can be configured like so:

```ruby
Bibliothecary.configure do |config|
  config.carthage_parser_host = 'http://my-carthage-parsing-service.com'
end
```

All available config options are in: https://github.com/khulnasoft-lab/bibliothecary/blob/master/lib/bibliothecary/configuration.rb

## Supported package manager file formats

- npm
  - package.json
  - package-lock.json
  - npm-shrinkwrap.json
  - yarn.lock
  - pnpm-lock.yaml
- Maven
  - pom.xml
  - ivy.xml
  - build.gradle
  - gradle-dependencies-q.txt
- RubyGems
  - Gemfile
  - Gemfile.lock
  - gems.rb
  - gems.locked
  - *.gemspec
- Packagist
  - composer.json
  - composer.lock
- PyPi
  - setup.py
  - req*.txt
  - req*.pip
  - requirements/*.txt
  - requirements/*.pip
  - Pipfile
  - Pipfile.lock
  - pyproject.toml
  - poetry.lock
  - uv.lock
- Nuget
  - packages.config
  - Project.json
  - Project.lock.json
  - *.nuspec
  - paket.lock
  - *.csproj
  - project.assets.json
- CycloneDX
  - XML as cyclonedx.xml
  - JSON as cyclonedx.json
  - Note that CycloneDX manifests can contain information on multiple
    package manager's packages!
- SPDX
  - tag:value as *.spdx
  - JSON as *.spdx.json
  - Note that SPDX manifests can contain information on multiple
    package manager's packages!
- Bower
  - bower.json
- CPAN
  - META.json
  - META.yml
- CocoaPods
  - Podfile
  - Podfile.lock
  - *.podspec
- Anaconda
  - environment.yml
  - environment.yaml
- Clojars
  - project.clj
- Meteor
  - versions.json
- CRAN
  - DESCRIPTION
- Cargo
  - Cargo.toml
  - Cargo.lock
- Hex
  - mix.exs
  - mix.lock
- Swift
  - Package.swift
  - Package.resolved
- Pub
  - pubspec.yaml
  - pubspec.lock
- Carthage
  - Cartfile
  - Cartfile.private
  - Cartfile.resolved
- Dub
  - dub.json
  - dub.sdl
- Julia
  - REQUIRE
- Shards
  - shard.yml
  - shard.lock
- Go
  - glide.yaml
  - glide.lock
  - Godeps
  - Godeps/Godeps.json
  - vendor/manifest
  - vendor/vendor.json
  - Gopkg.toml
  - Gopkg.lock
  - go.mod
  - go.sum
  - go-resolved-dependencies.json
- Elm
  - elm-package.json
  - elm_dependencies.json
  - elm-stuff/exact-dependencies.json
- Haxelib
  - haxelib.json
- Hackage
  - \*.cabal
  - cabal.config
- Actions
  - action.yml
  - action.yaml
  - .github/workflows/*.yml
  - .github/workflows/*.yaml
- Docker
  - Dockerfile
  - docker-compose.yml
- Vcpkg
  - vcpkg.json
- Homebrew
  - Brewfile
  - Brewfile.lock.json

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `bundle exec rspec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`.

To release a new version:
* in `CHANGELOG.md`, move the changes under `"Unreleased"` into a new section with your version number
* bump and commit the version number in `version.rb` in the `main` branch
* and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/khulnasoft-lab/bibliothecary. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.
