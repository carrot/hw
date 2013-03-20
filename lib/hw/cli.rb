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

    desc "add_source <name> <source>", "Add a source to ~/.hw/config"
    def add_source name, source
      header "Appending #{name} to #{CONFIG_PATH}"
      append_file CONFIG_PATH, "#{name}=#{source}\n"
    end

    desc "version", "display gem version information"
    def version
      dependency = Gem::Dependency.new('hw', Gem::Requirement::default)
      puts Gem::SpecFetcher::fetcher.find_matching(dependency, true, false, false).inspect
      versions = Gem::SpecFetcher::fetcher.find_matching(dependency, true, false, false).collect do |entry|
        if tuple = entry.first
          tuple[1]
        end
      end

      latest = versions.last.to_s

      if latest != VERSION
        error "Your version is out of date."
        info  "Your Version: #{VERSION}"
        info  "Current Version: #{latest}"
      else
        success "Your version is up to date."
        info  "Your Version: #{VERSION}"
      end
    end

    desc "update", "Update installed packages"
    method_option :pull, :aliases => "-p", :type => :boolean, :default => "true",  :desc => "Pull from remote sources"
    def update
      header "Updating hw"

      # Setup File Structure
      empty_directory DIRECTORY     unless File.exists? DIRECTORY
      empty_directory SOURCES_PATH  unless File.exists? SOURCES_PATH

      unless File.exists? CONFIG_PATH
        header "Adding default source to #{CONFIG_PATH}"

        create_file CONFIG_PATH
        self.class.new.invoke :add_source, ["default", DEFAULT_SOURCE] # self.class.new added else RSpec screws up.
      end

      # Iterate through sources and take appropriate actions. TODO: Refactor.
      if options["pull"]
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
      else
        warn "Sources not updated"
        info "Remove --pull=false to update your sources"
      end
    end
  end
end
