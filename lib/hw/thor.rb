module HW
  class Thor < ::Thor
    include Thor::Actions
    include Rails::Generators::Actions
    include HW::Actions
  end
end
