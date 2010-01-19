require 'fileutils'
# Uninstall hook code here

public_dir = File.dirname(__FILE__) + "/../../../public"

FileUtils.rm(public_dir + "/images/calendar.png")
FileUtils.rm_rf(public_dir + "/javascripts/jscalendar-1.0")
