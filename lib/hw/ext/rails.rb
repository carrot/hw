begin 
  require 'rails'
  require 'rails/generators/base'
  require 'active_record/errors'
  require 'active_record/migration'
rescue LoadError
  puts 'This package requires Rails generators.' 
  puts 'Please run `gem install rails` first!'
  exit(1)
end
