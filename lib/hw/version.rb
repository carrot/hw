class HW
  MAJOR = 1
  MINOR = 2
  TINY  = 0
  PRE   = 'beta2'

  VERSION = [MAJOR, MINOR, TINY, PRE].compact.join('.')
end
