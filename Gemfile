source "https://rubygems.org"

ruby "3.3.0"

gem "blueprinter", "~> 1.0"
gem "bootsnap", require: false
gem "pg", "~> 1.1"
gem "puma", ">= 5.0"
gem "rails", "~> 7.1.3", ">= 7.1.3.2"
gem "tzinfo-data", platforms: %i[windows jruby]

group :development, :test do
  gem "debug", platforms: %i[mri windows]
  gem "factory_bot_rails", "~> 6.4"
  gem "faker", "~> 3.3"
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
  gem "database_cleaner-active_record", "~> 2.1"
  gem "shoulda-matchers", "~> 6.0"
end
