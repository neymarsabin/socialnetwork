source 'https://rubygems.org'

git_source(:github) do |repo_name|
  repo_name = "#{repo_name}/#{repo_name}" unless repo_name.include?("/")
  "https://github.com/#{repo_name}.git"
end


gem 'rails', '~> 5.0.2'
gem 'mysql2', '>= 0.3.18', '< 0.5'
gem 'puma', '~> 3.0'
gem 'sass-rails', '~> 5.0'
gem 'uglifier', '>= 1.3.0'
gem 'coffee-rails', '~> 4.2'
gem 'jquery-rails'
gem 'turbolinks', '~> 5'
gem 'jbuilder', '~> 2.5'
gem 'bootstrap', '~> 4.0.0.alpha3'
gem 'devise'
gem 'simple_form'
gem 'acts_as_votable'
gem 'trix'
gem 'redis'
gem 'wysiwyg-rails'
gem 'activeadmin', github: 'activeadmin'
gem "paperclip", git: "git://github.com/thoughtbot/paperclip.git"
gem "friendly_id"
gem "recaptcha", require: "recaptcha/rails"
gem "dotenv-rails", require: 'dotenv/rails-now'
gem 'acts-as-taggable-on', '~> 4.0'
gem 'public_activity'
gem 'pundit'
gem 'cancan'

group :development, :test do
  gem 'byebug', platform: :mri
  gem 'better_errors'
  gem "binding_of_caller"
  gem 'rails-erd'
  gem 'railroady'
end

group :development do
  gem 'web-console', '>= 3.3.0'
  gem 'listen', '~> 3.0.5'
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
end

gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]
