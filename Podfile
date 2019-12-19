platform :ios, '11.0'

target 'SimpleNotes' do
  use_frameworks!

  # Pods for SimpleNotes

  target 'SimpleNotesTests' do
    inherit! :search_paths
    # Pods for testing
  end

  pod 'LBTATools'
  pod 'Sentry', '~> 4.4'
  pod 'Networking', '~> 5.0'
  pod 'AWSCognito'
  pod 'AWSCore'
  pod 'AWSS3'
  pod 'OneSignal', '>= 2.11.2', '< 3.0'

end

target 'NotificationServiceExtension' do
  use_frameworks!
  pod 'OneSignal', '>= 2.11.2', '< 3.0'
end