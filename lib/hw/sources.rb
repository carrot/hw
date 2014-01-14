require 'git'

module HW
  class Sources < Thor
    extend Thor::Actions
    extend Thor::Shell
    extend Actions

    class << self
      @@sources = {}

      def all
        if File.exists? CONFIG_PATH
          File.readlines(CONFIG_PATH).each do |line|
            source                = line.split("=")
            path                  = source[1].strip
            path                  = File.expand_path(path) if local_source?(path)
            @@sources[source[0]]  = path
          end
        end

        @@sources
      end

      def add name, source
        self.destination_root = "."
        header "Appending #{name} to #{CONFIG_PATH}"
        append_file CONFIG_PATH, "#{name}=#{source}\n"
      end

      def ensure_defaults
        self.destination_root = "~/.hw/"

        empty_directory DIRECTORY     unless File.exists? DIRECTORY
        empty_directory SOURCES_PATH  unless File.exists? SOURCES_PATH

        unless File.exists? CONFIG_PATH
          header "Adding default source to #{CONFIG_PATH}"
          create_file CONFIG_PATH
          add "default", DEFAULT_SOURCE
        end
      end

      def fetch
        self.all.each do |name, url|
          begin
            path  = "#{SOURCES_PATH}/#{name}"
            local = self.local_source?(url)
            
            unless local
              if File.exists?(path)
                Git.open(path, :log => nil).lib.send(:command, 'pull') # See: https://github.com/schacon/ruby-git/issues/32
              else
                Git.clone(url, name, :path => SOURCES_PATH)
              end
            end

            if local and !File.exists?(url)
              error "Local directory '#{url}' not found. Please check your sources at #{CONFIG_PATH}"
            else
              success "Successfully pulled updates from #{url} to #{SOURCES_PATH}#{name}"
            end
          rescue Git::GitExecuteError
            warn "Nothing was pulled from #{url}"
          end
        end
      end

      def local_source? path
        git_regex = /([A-Za-z0-9]+@|http(|s)\:\/\/)([A-Za-z0-9.]+)(:|\/)([A-Za-z0-9\-\/]+)/
        (path =~ git_regex).nil?
      end
    end
  end
end
