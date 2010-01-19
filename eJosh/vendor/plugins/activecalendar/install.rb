require 'fileutils'
# Install hook code here

public_dir = File.dirname(__FILE__) + "/../../../public"
plugin_dir = File.dirname(__FILE__) + "/public"

FileUtils.install(plugin_dir + "/images/calendar.png", public_dir + "/images")
FileUtils.cp_r(plugin_dir + "/javascripts/jscalendar-1.0", public_dir + "/javascripts")
