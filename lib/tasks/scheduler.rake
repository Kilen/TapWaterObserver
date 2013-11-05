desc "This task is called by the Heroku scheduler add-on"
task :send_mail=> :environment do
  puts "Sending mail..."
  PageController.new.send_mail
  puts "Send mail done!"
end
