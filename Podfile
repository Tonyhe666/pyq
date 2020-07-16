platform :ios, '13.0'
source 'https://github.com/CocoaPods/Specs.git'
use_frameworks!

workspace 'pyq'

project 'pyq/pyq.xcodeproj'


def basic_pods
    pod 'SDWebImage'
    pod 'SnapKit','4.2.0'
end

def main_pods
    basic_pods
end

target 'pyq' do
    project 'pyq.xcodeproj'
    main_pods
end


