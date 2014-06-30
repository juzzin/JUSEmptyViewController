Pod::Spec.new do |s|
  s.name          = "JUSEmptyViewController"
  s.version       = "0.9.1"
  s.summary       = "A UITable/CollectionView category for displaying a view when the datasource is empty."
  s.homepage      = "https://github.com/juzzin/JUSEmptyViewController"
  s.license       = { :type => 'MIT', :file => 'LICENSE' }
  s.author        = { "juzzin" => "nil@nil.nil" }
  s.platform      = :ios, '7.0'
  s.source        = { :git => "https://github.com/juzzin/JUSEmptyViewController.git", :tag => "v#{s.version}" }
  s.source_files  = 'JUSEmptyViewController/*.{h,m}', 'JUSEmptyViewController/**/*.{h,m,xib}'
  s.requires_arc  = true
  s.framework     = "UIKit"
end
