require_relative "lib/rakuten_securities_scraper/version"

Gem::Specification.new do |spec|
  spec.name          = "rakuten_securities_scraper"
  spec.version       = RakutenSecuritiesScraper::VERSION
  spec.authors       = ["FUMI-POPPIN"]
  spec.email         = ["fumitake.kawasaki@el-soul.com"]

  spec.summary       = "楽天証券スクレイパー / Rakuten Securities Scraper"
  spec.description   = "楽天証券スクレイパー / Rakuten Securities Scraper"
  spec.homepage      = "https://github.com/elsoul/rakuten_securities"
  spec.required_ruby_version = Gem::Requirement.new(">= 2.7.0")
  spec.license = "MIT"
  spec.metadata["homepage_uri"] = spec.homepage
  spec.metadata["source_code_uri"] = "https://github.com/elsoul/rakuten_securities_scraper"
  spec.metadata["changelog_uri"] = "https://github.com/elsoul/rakuten_securities_scraper"
  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files =
    Dir.chdir(File.expand_path(__dir__)) do
      `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
    end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]
end