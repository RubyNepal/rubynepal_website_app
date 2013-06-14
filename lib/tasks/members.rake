namespace :members do

  desc "Refresh member's data"
  task :refresh_data => :environment do
    Member.refresh_data
    puts "Data refresh completed"
  end

end