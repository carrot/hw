require 'git'
require 'thor'
require 'thor/group'
require 'hw/core_ext/string'

class HW < Thor
  autoload :Actions,  'hw/actions'
  autoload :Sources,  'hw/sources'
  autoload :Packages, 'hw/packages'
  
  #autoload :Rails,    'rails'
  #require 'rails/generators/base'
  
  DEFAULT_SOURCE  = "git@github.com:carrot/hw-packages.git"
  DIRECTORY       = File.expand_path("~/.hw/")
  CONFIG_PATH     = "#{DIRECTORY}/config"
  SOURCES_PATH    = "#{DIRECTORY}/sources/"
  RESERVED_WORDS  = %w(help)

  module Base
    class << self
      def included(base) # :nodoc:
        base.send :extend,  ClassMethods
        base.send :include, Thor::Actions
        base.send :include, Thor::Shell
        base.send :include, Actions
      end
    end

    module ClassMethods
      def reserved?(arg)
        arg = arg.first if arg.kind_of?(Array)
        Thor::THOR_RESERVED_WORDS.include?(arg) or Thor::HELP_MAPPINGS.include?(arg)
      end
    end
  end
end
