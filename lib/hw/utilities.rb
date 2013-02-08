module HW
  module Utilities
    DEFAULT_SOURCE  = "git@github.com:carrot/hw-packages.git"
    DIRECTORY       = File.expand_path("~/.hw/")
    CONFIG_PATH     = "#{DIRECTORY}/config"
    SOURCES_PATH    = "#{DIRECTORY}/sources/"
    RESERVED_WORDS  = %w(help system)

    def self.included(base) #:nodoc:
      base.extend ClassMethods
    end

    module ClassMethods
      def sources
        if File.exists? CONFIG_PATH
          sources = Hash.new

          File.readlines(CONFIG_PATH).each do |line|
            source              = line.split("=")
            path                = source[1].strip

            if self.local?(path)
              path = File.expand_path(path)
            end

            sources[source[0]]  = path
          end

          sources
        else
          {}
        end
      end

      def local? path
        git_regex = /([A-Za-z0-9]+@|http(|s)\:\/\/)([A-Za-z0-9.]+)(:|\/)([A-Za-z0-9\-\/]+)/
        (path =~ git_regex).nil?
      end
    end
  end
end
