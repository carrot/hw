module HW
  class Thor < ::Thor
    include Thor::Actions
    include Rails::Generators::Actions if defined?(Rails)
    include HW::Actions
  end
end
