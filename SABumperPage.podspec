Pod::Spec.new do |s|
  s.name = 'SABumperPage'
  s.version = '1.0.7'
  s.summary = 'SA Plugin Pumper Page'
  s.description = <<-DESC
    The SA Plugin Bumper Page to add to all ads
                       DESC
  s.homepage = 'https://github.com/SuperAwesomeLTD/sa-mobile-lib-ios-bumper'
  s.license = { 
	:type => 'GNU LESSER GENERAL PUBLIC LICENSE Version 3', 
	:file => 'LICENSE' 
  }
  s.author = { 
	'Gabriel Coman' => 'gabriel.coman@superawesome.tv' 
  }
  s.source = { 
	:git => 'https://github.com/SuperAwesomeLTD/sa-mobile-lib-ios-bumper.git', 
	:branch => 'master',
  	:tag => '1.0.7' 
  }
  s.ios.deployment_target = '8.0'
  s.source_files = 'Pod/Classes/**/*'
end
