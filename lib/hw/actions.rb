module HW
  module Actions
    def header msg
      say_status ">>>", "\e[36m#{msg}\e[0m", :cyan
    end

    def info msg;    say_status "info",    msg, :white;  end
    def success msg; say_status "success", msg, :green;  end
    def error msg;   say_status "error",   msg, :red;    end
    def warn msg;    say_status "warning", msg, :yellow; end

    def replace_file(destination, data = nil, config = {}, &block)
      remove_file(destination)
      create_file(destination, data, config, block)
    end

    def bundle
      header "Bundling gems"
      run "bundle install --quiet"
    end

    def migrate env = :development
      header "Migrating the database"
      rake "db:migrate", :env => env
    end

    def worker filename, data=nil, &block
      create_file("app/workers/#{filename}", data, :verbose => false, &block)
    end
  end
end
