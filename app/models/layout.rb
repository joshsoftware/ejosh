class Layout < ActiveRecord::Base
  has_many :themes
  has_attached_file :image,
    :styles => { :small_thumb => [ "50x50", :jpg ],  
            :medium_thumb => [ "75x75", :jpg ],
            :carousal => [ "81x81", :jpg ],
            :detail_preview => [ "210x210", :jpg ]},#size set according to picture size available in xhtmls(brands_review_detail.html)
    :url => "/images/layouts/:id/:style/:basename.:extension",
    :default_url => "public/images/layouts/:id/:style.jpg"
  validates_attachment_content_type :image, :content_type => ['image/pjpeg','image/jpeg', 'image/png','image/x-png','image/gif'], :message=>"Invalid file format " 

end
