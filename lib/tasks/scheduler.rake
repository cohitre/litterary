namespace :deadline do
  desc "Creates a new week and publishes it"
  task :trigger => :environment do
    Week
      .create!(publishing_date: Time.now)
      .claim_posts!
  end
end
