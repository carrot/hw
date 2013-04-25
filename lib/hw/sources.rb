class HW
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
        append_file CONFIG_PATH, "#{name}=#{source}\n"
      end

      def git_clone
        # TODO: Clone git repo
      end

      def git_pull
        # TODO: Pull changes from git repo
      end

      def local_source? path
        git_regex = /([A-Za-z0-9]+@|http(|s)\:\/\/)([A-Za-z0-9.]+)(:|\/)([A-Za-z0-9\-\/]+)/
        (path =~ git_regex).nil?
      end
    end
  end
end
