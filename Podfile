platform :ios, '9.0'
use_frameworks!

def install_pods
  pod 'Alamofire', '4.4.0'
  pod 'AlamofireImage', '3.2.0'
  pod 'Alamofire-SwiftyJSON', '2.0.0-beta.1'
end

target 'gnavi-api-demo' do
  install_pods
  # Pods for gnavi-api-demo

  target 'gnavi-api-demoTests' do
    install_pods
    inherit! :search_paths
    # Pods for testing
  end

end

plugin 'cocoapods-keys', {
  :project => "gnavi-api-demo",
  :keys => [
    "GnaviApiKey"
]}
