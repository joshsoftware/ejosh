class Site < ActiveRecord::Base

  has_attached_file :logo,
    :styles => { :small_thumb => [ "100x100", :jpg ],  
            :layout_1 => [ "280x130", :jpg ],
            :layout_2 => [ "270x110", :jpg ],
            :layout_3 => [ "240x140", :jpg ]}
    validates_attachment_content_type :logo, :content_type => ['image/pjpeg','image/jpeg', 'image/png','image/x-png','image/gif'], :message=>"Invalid file format "  

end
