class HW
  module Actions
    extend Thor::Actions

    def header msg
      say_status ">>>", "\e[36m#{msg}\e[0m", :cyan
    end

    def info msg;    say_status "info",    msg, :white;  end
    def success msg; say_status "success", msg, :green;  end
    def error msg;   say_status "error",   msg, :red;    end
    def warn msg;    say_status "warning", msg, :yellow; end

    def replace_file(destination, data = nil, config = {}, &block)
      remove_file(destination)
      create_file(destination, (data || block.call()), config)
    end

    def bundle
      header "Bundling gems"
      run "bundle install --quiet"
    end

    def migrate(options={})
      header "Migrating the database"
      env = options[:env] || 'development'
      rake("db:migrate", env: env, silence: true)
    end

    def worker filename, data=nil, &block
      create_file("app/workers/#{filename}", data, verbose: false, &block)
    end

    def rake(command, options={})
      env     = options[:env] || 'development'
      capture = options[:silence] || false
      sudo    = options[:sudo] ? 'sudo ' : ''

      #run  rake db:create from "./testing"
      #success
      run("#{sudo}rake #{command} RAILS_ENV=#{env}", verbose: false, capture: capture)
    end

    def git(commands={})
      if commands.is_a?(Symbol)
        run "git #{commands}"
      else
        commands.each do |cmd, options|
          run "git #{cmd} #{options}"
        end
      end
    end
  end
end
