module HW
  class CLI < HW::Thor
    def self.start(given_args = ARGV, config = {})
      unless ARGV.empty? or self.instance_methods(false).include?(ARGV.first.to_sym)
        name = ARGV.first

        if HW::Packages.reserved?(name)
          HW::Packages.register(name, "hw/packages/#{name}")
        else
          HW::Packages.add(name)
        end
      end

      super(given_args, config)
    end

    desc "list", "list available packages"
    def list
      header "Listing available packages"
      Thor::Shell::Basic.new.print_in_columns(HW::Packages.list)
    end

    desc "add_source <name> <source>", "Add a source to ~/.cbrc"
    def add_source name, source
      HW::Sources.add

      header "Appending #{name} to #{CONFIG_PATH}"
      append_file CONFIG_PATH, "#{name}=#{source}\n"
    end

    desc "version", "display gem version information"
    def version
      # TODO: display version information and if up to date
    end

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
  end
end
