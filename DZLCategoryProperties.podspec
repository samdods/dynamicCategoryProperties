
Pod::Spec.new do |s|


  s.name         = "DZLCategoryProperties"
  s.version      = "1.0.0"
  s.summary      = "Dynamic Accessors for Category Properties"

  s.description  = <<-DESC
Using the methods defined in this `NSObject` category, you can simplify implementation of properties in your own categories.
Simply declare your category properties as `@dynamic` and call one of the implementor methods from the `+load` method of your category.
                   DESC

  s.homepage     = "https://github.com/samdods/dynamicCategoryProperties"



  s.license      = 'MIT'



  s.author       = { "Sam Dods" => "dods.sam@gmail.com" }



  s.platform     = :ios, '5.0'




  s.source       = { :git => "https://github.com/samdods/dynamicCategoryProperties.git", :tag => s.version.to_s }



  s.source_files  = 'DZLCategoryProperties/*.{h,m}'








  s.frameworks = 'Foundation'




  s.requires_arc = true


end
