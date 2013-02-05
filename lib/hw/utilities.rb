module HW
  module Utilities
    extend ActiveSupport::Concern

    included do
      DEFAULT_SOURCE  = "git@github.com:carrot/hw-packages.git"
      DIRECTORY       = File.expand_path("~/.hw/")
      CONFIG_PATH     = "#{DIRECTORY}/config"
      SOURCES_PATH    = "#{DIRECTORY}/sources/"
      RESERVED_WORDS  = %w(help system)
      SOURCES         = self.sources
    end

    module ClassMethods
      def sources
        if File.exists? CONFIG_PATH
          sources = Hash.new

          File.readlines(CONFIG_PATH).each do |line|
            source              = line.split("=")
            sources[source[0]] = source[1].strip
          end

          sources
        else
          {}
        end
      end
    end
  end
end
