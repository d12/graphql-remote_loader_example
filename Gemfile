source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '2.4.2'

gem 'rails', '~> 5.2.0'
gem 'sqlite3'
gem 'puma', '~> 3.11'
gem 'bootsnap'

gem 'graphql-remote_loader', '~> 1.0.0'
gem 'graphql-client'

group :development, :test do
  gem 'byebug', platforms: [:mri, :mingw, :x64_mingw]
end

group :development do
  gem 'listen', '>= 3.0.5', '< 3.2'
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
end

gem 'graphiql-rails', group: :development
