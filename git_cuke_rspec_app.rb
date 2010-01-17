#!/usr/bin/env ruby

run "echo TODO > README"

file ".gitignore", <<-END
.gitignore
log/*
tmp/*
config/database.yml
db/*.sqlite*
END

run "cp config/database.yml config/example_database.yml"
run "cp .gitignore example_gitignore"

inside('config') do 
  run 'echo "config.gem \'rspec\', :lib => false" >> environments/test.rb'
  run 'echo "config.gem \'rspec-rails\', :lib => false" >> environments/test.rb'
  run 'echo "config.gem \'cucumber\', :lib => false" >> environments/test.rb'
  run 'echo "config.gem \'cucumber-rails\', :lib => false" >> environments/test.rb'
  run 'echo "config.gem \'webrat\', :lib => false" >> environments/test.rb'
  run 'echo "config.gem \'factory_girl\', :lib => false" >> environments/test.rb'
end

if yes?("Install gems as root?")
  run "sudo rake gems:install RAILS_ENV=test"
else
  rake "gems:install RAILS_ENV=test"
end
  
generate :rspec
generate :cucumber
#run "script/generate cucumber"

git :init
git :add => "."
git :commit => "-m 'initial commit'"
