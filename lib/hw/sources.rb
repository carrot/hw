module HW::Sources
  @@sources = {}

  def self.all
    if File.exists? CONFIG_PATH
      File.readlines(CONFIG_PATH).each do |line|
        source                = line.split("=")
        path                  = source[1].strip
        path                  = File.expand_path(path) if self.local_source?(path)
        @@sources[source[0]]  = path
      end
    end

    @@sources
  end

  def self.add
    # TODO: Currently a part of the System package
  end

  def self.git_clone
    # TODO: Clone git repo
  end

  def self.git_pull
    # TODO: Pull changes from git repo
  end

  def self.local_source? path
    git_regex = /([A-Za-z0-9]+@|http(|s)\:\/\/)([A-Za-z0-9.]+)(:|\/)([A-Za-z0-9\-\/]+)/
    (path =~ git_regex).nil?
  end
end
