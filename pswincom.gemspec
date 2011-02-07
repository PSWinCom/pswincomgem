Gem::Specification.new do |s|
  s.name            = 'pswincom'
  s.version         = '0.1.1'
  s.authors         = ['PSWinCom AS']
  s.email           = ['support@pswin.com']
  s.homepage        = 'http://github.com/tormaroe/pswincomgem'

  s.summary         = "API for the PSWinCom SMS Gateway."
  s.description     = "An easy to use API for the PSWinCom SMS Gateway, allowing you to send SMS messages."

  s.add_dependency('builder', '>= 3.0.0')

  s.files           = Dir.glob("{bin,lib}/**/*") + %w(LICENSE README.md)
  s.require_path    = 'lib'
end
