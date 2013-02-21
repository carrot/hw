module HW::Packages
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

      # Iterate through sources and take appropriate actions. TODO: Refactor.
      HW::Sources.all.each do |name, url|
        begin
          path  = "#{SOURCES_PATH}/#{name}"
          local = HW::Sources.local_source?(url)

          unless local
            if File.exists?(path)
              Git.open(path).pull
            else
              Git.clone(url, name, :path => SOURCES_PATH) unless local
            end
          end

          if local and !File.exists?(url)
            error "Local directory '#{url}' not found. Please check your sources at #{CONFIG_PATH}"
          else
            success "Successfully pulled updates from #{url} to #{SOURCES_PATH}#{name}"
          end
        rescue Git::GitExecuteError => e
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
