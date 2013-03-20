require 'fileutils'
include FileUtils

fake_home   = File.join('/tmp', 'gems', 'hw', 'fakehome')
ENV['HOME'] = fake_home

require 'hw'

RSpec.configure do |config|
  config.before do
    rm_rf   fake_home if File.exists? fake_home
    mkdir_p fake_home

    ARGV.replace []
  end

  config.expect_with :rspec do |c|
    c.syntax = :expect
  end

  def capture(stream)
    begin
      stream = stream.to_s
      eval "$#{stream} = StringIO.new"
      yield
      result = eval("$#{stream}").string
    ensure
      eval("$#{stream} = #{stream.upcase}")
    end

    result
  end

  # def source_root
  #   File.join(File.dirname(__FILE__), 'fixtures')
  # end

  # def destination_root
  #   File.join(File.dirname(__FILE__), 'sandbox')
  # end

  alias :silence :capture
end
