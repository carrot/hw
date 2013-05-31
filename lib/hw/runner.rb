require 'hw/base'

class HW::Runner < HW
  include Base

  def self.start(given_args = ARGV, config = {})
    unless self.is_a_reserved_task?(given_args)
      name = ARGV.first

      if Packages.reserved?(name)
        Packages.register(name, "hw/packages/#{name}")
      else
        Packages.add(name)
      end
    end

    super(given_args, config)
  end

  desc "list", "list available packages"
  def list
    Packages.formatted_list
  end

  desc "add_source <name> <source>", "Add a source to ~/.hw/config"
  def add_source name, source
    Sources.add(name, source)
  end

  desc "update", "Update installed packages"
  method_option :pull, :aliases => "-p", :type => :boolean, :default => "true",  :desc => "Pull from remote sources"
  def update
    header "Updating hw"
    Sources.ensure_defaults 

    if options["pull"]
      Sources.fetch
    else
      warn "Sources not updated"
      info "Remove `-p false` to update your sources"
    end
  end
  
  desc "install", "Update installed packages"
  method_option :pull, :aliases => "-p", :type => :boolean, :default => "true",  :desc => "Pull from remote sources"
  alias :install :update

  no_tasks do
    def self.is_a_reserved_task? args
      ARGV.empty? or reserved?(args) or self.instance_methods(false).include?(args.first.to_sym)
    end
  end
end
