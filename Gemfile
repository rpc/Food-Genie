source 'http://rubygems.org'

gem 'rails', '~> 3.2.0'
gem 'therubyracer'
gem "nested_form"
gem 'jquery-rails'

gem "rspec-rails", :group => [:test, :development]

group :development do
  gem 'sqlite3'
  gem 'mongrel', '~> 1.2.0.pre2'
  gem 'debugger'
  gem 'looksee' # <qualquer_objecto>.ls lista metodos possiveis
  gem 'wirble' # cores
  gem 'hirb' # tabelas bonitas. fazer Hirb.enable na console (looksee deixa de funcionar bem)
  gem 'awesome_print' # consola: $ ap <objecto>
  gem 'quiet_assets' # hide assets output in log  
end

group :production do
  #gem 'pg'
end

group :test do
  # Pretty printed test output
  gem 'turn'
  gem 'factory_girl_rails'
  gem 'minitest'
  gem 'mocha'
  gem 'selenium-webdriver'
  gem 'capybara'  
  gem 'launchy'
  gem "guard-rspec"
  gem 'capybara-webkit'
end

group :assets do
  gem 'sass-rails',   '~> 3.2.3'
  gem 'coffee-rails', '~> 3.2.1'
  gem 'uglifier', '>= 1.0.3'
end



