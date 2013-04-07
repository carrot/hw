class HW
  module Packages
    extend self

    @@packages = {}

    def add name
      Sources.all.each do |key, path|
        full_path = if HW::Sources.local_source?(path)
          File.join(path, "#{name}.rb")
        else
          File.join(SOURCES_PATH, key, "#{name}.rb")
        end

        @@packages[name] = full_path if File.exists?(full_path)
      end

      if reserved?(name)
        puts "'#{name}' is a reserved word and cannot be defined as a package"
        exit(1)
      end

      register(name, @@packages[name])
    end

    def register name, file
      raise LoadError if file.nil? # TODO: Don't use exception handling.
      require file
      klass = Packages::const_get(name.to_pkg)
      Thor.register(klass, name, "#{name} <command>", "")
    rescue LoadError
      puts "The package '#{name}' was not found in any of the sources"
      exit(1)
    end

    def list
      Sources.all.keys.each do |directory|
        full_path = File.join(SOURCES_PATH, directory, "*.rb")

        Dir[full_path].each do |file|
          key             = File.basename(file, '.rb')
          @@packages[key] = file
        end
      end

      @@packages.merge!({ 'system' => nil, 'help' => nil })
      @@packages.keys.sort
    end

    def reserved? name
      RESERVED_WORDS.include?(name.downcase)
    end
  end
end
