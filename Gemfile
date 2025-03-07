source "https://rubygems.org"

# Use specific branch of Rails
gem "rails", github: "rails/rails", branch: "8-0-stable"

gem "pg"
gem "puma", ">= 5.0"

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem "tzinfo-data", platforms: %i[ windows jruby ]

gem "good_job"
gem "faraday"

group :development, :test do
  gem "debug", platforms: %i[ mri windows ], require: "debug/prelude"

  gem "brakeman", require: false

  gem "rubocop-rails-omakase", require: false

  gem "vcr"
  gem "webmock"
end
