require 'git'
require 'thor'
require 'thor/group'
require 'httparty'
require 'active_support/all'
require 'rails/generators/actions'

require 'rubygems'
require 'rubygems/spec_fetcher'
require 'rubygems/specification'

module HW
  VERSION         = "1.1.0"
  DEFAULT_SOURCE  = "git@github.com:carrot/hw-packages.git" # CLI
  DIRECTORY       = File.expand_path("~/.hw/")              # CLI, HW
  CONFIG_PATH     = "#{DIRECTORY}/config"                   # CLI, Sources
  SOURCES_PATH    = "#{DIRECTORY}/sources/"                 # CLI, Packages
  RESERVED_WORDS  = %w(help)                                # Packages
end

require 'hw/core_ext/string'
require 'hw/actions'
require 'hw/thor'
require 'hw/sources'
require 'hw/packages'
require 'hw/cli'
