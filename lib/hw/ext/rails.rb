begin 
  require 'rails'
  require 'rails/generators/base'
rescue LoadError
  puts 'This package requires Rails generators.' 
  puts 'Please run `gem install rails` first!'
  exit(1)
end
