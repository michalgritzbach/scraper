source "https://rubygems.org"

ruby "3.3.0"

gem "bootsnap", require: false
gem "httparty", "~> 0.22.0"
gem "oj", "~> 3.16"
gem "pg", "~> 1.1"
gem "puma", ">= 5.0"
gem "rails", "~> 7.1.3", ">= 7.1.3.2"
gem "service_actor-rails", "~> 1.0"
gem "tzinfo-data", platforms: %i[windows jruby]

group :development, :test do
  gem "debug", platforms: %i[mri windows]
  gem "rspec-rails"
  gem "standard"
  gem "standard-rails"
end

group :development do
  gem "guard"
  gem "guard-bundler"
  gem "guard-rspec"
  gem "guard-standardrb"
end

group :test do
  gem "vcr", "~> 6.2"
  gem "webmock", "~> 3.23"
end
