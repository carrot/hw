module HW
  module Packages
    class System < HW::Thor
      desc "update", "Update installed packages"
      def update
        header "Updating hw"

        # Setup File Structure
        empty_directory DIRECTORY     unless File.exists? DIRECTORY
        empty_directory SOURCES_PATH  unless File.exists? SOURCES_PATH

        unless File.exists? CONFIG_PATH
          header "Adding default source to #{CONFIG_PATH}"

          create_file CONFIG_PATH
          invoke :add_source, ["default", DEFAULT_SOURCE]
        end

        SOURCES.each do |name, url|
          begin
            repo_path = "#{SOURCES_PATH}/#{name}"

            if File.exists?(repo_path)
              git = Git.open(repo_path)
              git.pull
            else
              Git.clone(url, name, :path => SOURCES_PATH)
            end
            success "Successfully pulled updates from #{url} to #{SOURCES_PATH}#{name}"
          rescue Git::GitExecuteError => e
            error e.inspect
            warn "Nothing was pulled from #{url}"
          end
        end
      end

      desc "add_source <name> <source>", "Add a source to ~/.cbrc"
      def add_source name, source
        header "Appending #{name} to #{CONFIG_PATH}"
        append_file CONFIG_PATH, "#{name}=#{source}\n"
      end
    end
  end
end
