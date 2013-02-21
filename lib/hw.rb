DEFAULT_SOURCE  = "git@github.com:carrot/hw-packages.git" # System
DIRECTORY       = File.expand_path("~/.hw/")              # Hw, System
CONFIG_PATH     = "#{DIRECTORY}/config"                   # System, Sources
SOURCES_PATH    = "#{DIRECTORY}/sources/"                 # System, Packages
RESERVED_WORDS  = %w(help system)                         # Packages

require 'git'
require 'thor'
require 'thor/group'
require 'httparty'
require 'rails/generators/actions'

require 'hw/core_ext/string'
require 'hw/version'
require 'hw/actions'
require 'hw/sources'
require 'hw/packages'
require 'hw/cli'

module HW
end
