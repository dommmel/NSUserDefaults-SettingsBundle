Pod::Spec.new do |spec|
  spec.name         = 'NSUserDefaults+SettingsBundle'
  spec.version      = '0.0.2'
  spec.license      = { :type => 'MIT' }
  spec.homepage     = "https://github.com/dommmel/NSUserDefaults-SettingsBundle"
  spec.authors      = { "Dominik Heier" => "dommmel@gmail.com" }
  spec.summary      = 'Initialize your NSUserDefaults values with the "DefaultValue" of your Settings.bundle/Root.plist file'
  spec.source       = { 
    :git => 'https://github.com/dommmel/NSUserDefaults-SettingsBundle.git', 
    :tag => spec.version.to_s 
  }
  spec.source_files = 'NSUserDefaults+SettingsBundle.{h,m}'
  spec.requires_arc = true
end