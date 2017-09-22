
Pod::Spec.new do |s|
  s.name             = "AuroraIMUI"
  s.version          = "0.5.3_k"
  s.summary          = "An messages UI library for iOS."

  s.homepage         = "https://www.jiguang.cn"
  s.license          = "MIT"
  s.author           = "jpush"
  s.source           = { :git => "https://github.com/jpush/aurora-imui.git", :tag => s.version.to_s }

  s.requires_arc          = true

  s.ios.deployment_target = "8.0"

  s.source_files     = "iOS/IMUICommon/*.{swift,h}", "iOS/IMUICommon/**/*.{swift,h}", "iOS/IMUIMessageCollectionView/*.{swift,h}", "iOS/IMUIMessageCollectionView/**/*.{swift,h}"
  s.resources        = "iOS/IMUIMessageCollectionView/Assets/IMUIAssets.bundle", "iOS/IMUICommon/**/*.{xib}", "iOS/IMUICommon/**/**/*.{xib}", "iOS/IMUIMessageCollectionView/**/*.{xib}", "iOS/IMUIMessageCollectionView/**/**/*.{xib}"
  s.frameworks       = "QuartzCore", "CoreGraphics", "CoreLocation", "MapKit", "AVFoundation"
end