Before do
  @aruba_timeout_seconds = 12

  @real_home  = ENV['HOME']
  fake_home   = File.join('/tmp', 'gems', 'hw', 'fakehome')

  rm_rf   fake_home if File.exists? fake_home
  mkdir_p fake_home

  ENV['HOME'] = fake_home
end

After do
  ENV['HOME'] = @real_home
end
