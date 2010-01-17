#!/usr/bin/env ruby

jquery_version = ENV["JQUERY_VERSION"] || "1.4"
jquery_ui_version = ENV["JQUERY_UI_VERSION"] || "1.7.2"

plugin "jrails", :git => "git://github.com/aaronchi/jrails.git"
run "curl http://code.jquery.com/jquery-#{jquery_version}.js > public/javascripts/jquery-#{jquery_version}.js"
run "rm public/javascripts/controls.js public/javascripts/dragdrop.js public/javascripts/effects.js public/javascripts/prototype.js"
if yes?("Do you want to include the full jQuery UI library?")
  run "curl http://jqueryui.com/download/jquery-ui-#{jquery_ui_version}.custom.zip > /tmp/jquery-ui-#{jquery_ui_version}.custom.zip"
  run "unzip -o /tmp/jquery-ui-#{jquery_ui_version}.custom.zip -d /tmp/"
  run "mv /tmp/development-bundle/ui public/javascripts"
  run "mv /tmp/css/smoothness/images/* public/images/"
  run "mv /tmp/css/smoothness public/stylesheets"
  run "rm -rf public/stylesheets/smoothness/images"
  run "rm -rf /tmp/jquery-ui-#{jquery_ui_version}.custom.zip /tmp/development-bundle/ /tmp/css /tmp/js"
  run "mv public/javascripts/ui/jquery-ui-#{jquery_ui_version}.custom.js public/javascripts/jquery-ui.js"
  notify_ui = true
end
puts "Remember to include jquery-#{jquery_version} in your application layout"
if notify_ui
  puts "Remember to include jquery-ui in your application layout"
  puts "You need to include each particular effects and components for jquery-ui by hand. You will find a list of these files under public/javascripts/ui. You can also check the documentation and demos on http://jqueryui.com/docs/Getting_Started"
end
