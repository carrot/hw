class String
  def to_pkg
    # TODO: Remove reliance on ActiveSupport
    string = self.to_s.sub(/^[a-z\d]*/) { $&.capitalize }
    string.gsub(/(?:_|(\/))([a-z\d]*)/) { "#{$1}#{$2.capitalize}" }.gsub('/', '::')
  end
end
