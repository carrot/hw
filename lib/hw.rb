require 'git'
require 'thor'
require 'thor/group'
require 'rails/generators/base'

module HW
  DEFAULT_SOURCE  = "git@github.com:carrot/hw-packages.git" # CLI
  DIRECTORY       = File.expand_path("~/.hw/")              # CLI, HW
  CONFIG_PATH     = "#{DIRECTORY}/config"                   # CLI, Sources
  SOURCES_PATH    = "#{DIRECTORY}/sources/"                 # CLI, Packages
  RESERVED_WORDS  = %w(help)                                # Packages
end

require 'hw/core_ext/string'
require 'hw/version'
require 'hw/actions'
require 'hw/thor'
require 'hw/sources'
require 'hw/packages'
require 'hw/cli'
