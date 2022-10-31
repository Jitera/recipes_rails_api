if Doorkeeper::Application.count.zero?
  Doorkeeper::Application.create!(name: 'Web Client', redirect_uri: '', scopes: '')
  # other applications
end

User.create(email: 'user1@example.com',
                     password: 'password',
                     password_confirmation: 'password')
User.create(email: 'user2@example.com',
                     password: 'password',
                     password_confirmation: 'password')
