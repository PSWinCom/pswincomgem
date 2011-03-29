Gem::Specification.new do |s|
  s.name            = 'pswincom'
  s.version         = '0.1.5'
  s.authors         = ['PSWinCom AS']
  s.email           = ['post@pswin.com']
  s.homepage        = 'http://github.com/tormaroe/pswincomgem'

  s.summary         = "API for the PSWinCom SMS Gateway."
  s.description     = "An easy to use API for the PSWinCom SMS Gateway, allowing you to send SMS messages."

  s.add_dependency('builder', '>= 2.1.2')

  s.default_executable = "sms"
  s.executables     = ["sms"]

  s.files           = Dir.glob("{bin,lib}/**/*") + %w(LICENSE README.md)
  s.require_path    = 'lib'
end
