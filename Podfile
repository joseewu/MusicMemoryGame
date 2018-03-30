platform :ios, '9.0'
use_frameworks!
def main_sources
#define your pod resources
pod 'Alamofire'
pod 'AudioKit', '~> 4.0'
end
def test_sources
#define your pod resources for unit test

end
target 'MusicMemoryGame' do
main_sources

  target 'MusicMemoryGameTests' do
    inherit! :search_paths
    test_sources
  end

  target 'MusicMemoryGameUITests' do
    inherit! :search_paths
    test_sources
  end

end
