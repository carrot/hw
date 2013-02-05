require 'cb/base'

module CB
  class Thor < ::Thor
    include Thor::Actions
    include Rails::Generators::Actions
    include CB::Utilities
    include CB::Actions
  end

  class CLI < CB::Thor
    def self.start(given_args = ARGV, config = {})
      packages = Hash.new

      if ARGV.empty?
        SOURCES.keys.each do |directory|
          full_path = File.join(SOURCES_PATH, directory, "*.rb")

          Dir[full_path].each do |file|
            key           = File.basename(file, '.rb')
            packages[key] = file
          end
        end

        packages.merge!({ 'system' => nil, 'help' => nil })

        Thor::Shell::Basic.new.print_in_columns(packages.keys.sort)
      else
        name = ARGV.first

        if name != 'settings'
          if %w(system help).include?(name)
            require 'cb/packages/system'
            register(CB::Packages::System, "system", "system <command>", "Perform system commands")
          else
            SOURCES.keys.each do |directory|
              full_path       = File.join(SOURCES_PATH, directory, "#{name}.rb")
              packages[name]  = full_path if File.exists?(full_path)
            end

            require packages[name]
            pkg_name = name.to_pkg

            if RESERVED_WORDS.include?(pkg_name.downcase)
              raise "#{pkg_name} is a reserved word and cannot be defined as a package"
            end

            klass = CB::Packages::const_get(pkg_name)
            register(klass, name, "#{name} <command>", "")
          end
        end
      end

      super(given_args, config)
    end

    desc "settings", "Display cb settings information"
    def settings
      hidden    = %w(ClassMethods)
      constants = CB::Utilities.constants.reject { |c| hidden.include?(c) }
      rows      = Array.new

      constants.each { |constant| rows << [constant, CB::Utilities::const_get(constant)] }

      Thor::Shell::Basic.new.print_table(rows)
    end
  end
end
