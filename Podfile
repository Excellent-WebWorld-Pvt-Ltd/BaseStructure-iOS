# Uncomment the next line to define a global platform for your project
platform :ios, '13.0'


target 'BaseStructure' do
 
  	use_frameworks!
	inhibit_all_warnings!

  	pod 'IQKeyboardManagerSwift'
 	pod 'Kingfisher', '~> 6.0'
 	pod 'SwiftLint'

	post_install do |installer|
     	 installer.pods_project.targets.each do |target|
          	target.build_configurations.each do |config|
              		config.build_settings['LD_NO_PIE'] = 'NO'
              		config.build_settings['IPHONEOS_DEPLOYMENT_TARGET'] = '12.1'
              		config.build_settings['GCC_WARN_INHIBIT_ALL_WARNINGS'] = "YES"
          	end
      	    end
  	end
end
