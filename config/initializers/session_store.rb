# Be sure to restart your server when you modify this file.

# Your secret key for verifying cookie session data integrity.
# If you change this key, all old sessions will become invalid!
# Make sure the secret is at least 30 characters and all random, 
# no regular words or you'll be exposed to dictionary attacks.
ActionController::Base.session = {
  :key         => '_gescom-onrails_session',
  :secret      => 'dbc1d98097bb99839c87a268be64a5a2ab367b4b980dbfc428b0c11f7bd0b59e23c41bff873aaf05353ad671fb913ada908cdd8c6af0582353440301b3d265c2'
}

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rake db:sessions:create")
# ActionController::Base.session_store = :active_record_store
