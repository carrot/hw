DEFAULT_SOURCE  = "git@github.com:carrot/hw-packages.git"
DIRECTORY       = File.expand_path("~/.hw/")
CONFIG_PATH     = "#{DIRECTORY}/config"
SOURCES_PATH    = "#{DIRECTORY}/sources/"
RESERVED_WORDS  = %w(help system)

require 'git'
require 'thor'
require 'thor/group'
require 'httparty'
require 'active_support/all' #/concerns
require 'rails/generators/actions'

require 'hw/core_ext/string'
require 'hw/version'
require 'hw/actions'
require 'hw/sources'
require 'hw/packages'
require 'hw/cli'

module HW
end
