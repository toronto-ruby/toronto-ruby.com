namespace :admins do
  desc 'Upsert admin users from Rails.application.credentials.admins'
  task sync: :environment do
    admins = Rails.application.credentials.admins ||
             (Rails.env.production? ? raise('admins missing from credentials') : [{ username: 'trbadmin', password: 'admin' }])

    admins.each do |attrs|
      user = User.find_or_initialize_by(username: attrs[:username])
      user.password = attrs[:password]
      user.save!
    end
  end
end
