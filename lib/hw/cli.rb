module HW
  class Thor < ::Thor
    include Thor::Actions
    include Rails::Generators::Actions
    include HW::Actions
  end

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
      Thor::Shell::Basic.new.print_in_columns(HW::Packages.list)
    end

    desc "version", "display gem version information"
    def version
      # TODO: display version information and if up to date
    end
  end
end
