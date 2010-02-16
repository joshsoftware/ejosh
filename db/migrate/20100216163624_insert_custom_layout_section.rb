class InsertCustomLayoutSection < ActiveRecord::Migration
  def self.up
    PageSection.create(:title => "Custom Content Theme1", :display_name => "Custom_Content_Theme1",:content => "<div id=\"display\">\r\n<div id=\"displayleft\">&nbsp;</div>\r\n<div id=\"displayright\">&nbsp;</div>\r\n<div id=\"displaymid\">\r\n<div id=\"shell\">\r\n<div id=\"i1\">\r\n<div class=\"controlpanel\"><img src=\"images/ejoshweb1/image1.png\" border=\"0\" /></div>\r\n<br /> Have your own <br /> control panel</div>\r\n<div id=\"i2\">\r\n<div class=\"colors\"><img src=\"images/ejoshweb1/image2.png\" border=\"0\" /></div>\r\n<br /> Customize<br /> using your own <br /> colors</div>\r\n<div id=\"i3\">\r\n<div class=\"layouts\"><img src=\"images/ejoshweb1/image3.png\" border=\"0\" /></div>\r\n<br />\r\n<div class=\"mar\">Customize using  <br /> your own  layouts</div>\r\n</div>\r\n<div id=\"i4\">\r\n<div class=\"plugin\"><img src=\"images/ejoshweb1/image4.png\" border=\"0\" /></div>\r\n<br />\r\n<div class=\"mar1\">Plug-in your <br />customized<br /> Applications</div>\r\n</div>\r\n</div>\r\n</div>\r\n</div>", :is_processing_reqd => false)
  end

  def self.down
  end
end
