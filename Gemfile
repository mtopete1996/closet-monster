source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '2.7.2'

gem 'active_storage_validations', '~> 0.9.0'
gem 'aws-sdk-s3', require: false
gem 'bootsnap', '>= 1.4.2', require: false
gem 'devise', '~> 4.7', '>= 4.7.3'
gem 'draper', '~> 4.0', '>= 4.0.1'
gem 'font_awesome5_rails', '~> 1.3'
gem 'haml', '~> 5.2'
gem 'image_processing', '~> 1.12', '>= 1.12.1'
gem 'jbuilder', '~> 2.7'
gem 'kaminari', '~> 1.2', '>= 1.2.1'
gem 'pg', '~> 1.2', '>= 1.2.3'
gem 'puma', '~> 4.1'
gem 'rails', '~> 6.0.3', '>= 6.0.3.3'
gem 'rubocop', '~> 1.22', '>= 1.22.1'
gem 'sass-rails', '>= 6'
gem 'simple_calendar', '~> 2.4', '>= 2.4.3'
gem 'turbolinks', '~> 5'
gem 'webpacker', '~> 4.0'

group :development, :test do
  gem 'byebug', platforms: %i[mri mingw x64_mingw]
end

group :development do
  gem 'capistrano',         require: false
  gem 'capistrano-rvm',     require: false
  gem 'capistrano-rails',   require: false
  gem 'capistrano-bundler', require: false
  gem 'capistrano3-puma',   require: false
  gem 'listen', '~> 3.2'
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
  gem 'web-console', '>= 3.3.0'
end

group :test do
  gem 'capybara', '>= 2.15'
  gem 'selenium-webdriver'
  gem 'sqlite3', '~> 1.4'
  gem 'timecop', '~> 0.9.4'
  gem 'webdrivers'
end

gem 'tzinfo-data', platforms: %i[mingw mswin x64_mingw jruby]
