# Be sure to restart your server when you modify this file.

# Your secret key for verifying cookie session data integrity.
# If you change this key, all old sessions will become invalid!
# Make sure the secret is at least 30 characters and all random, 
# no regular words or you'll be exposed to dictionary attacks.
ActionController::Base.session = {
  :key         => '_eJosh_session',
  :secret      => 'ada9792bce541e99f051cb5669385e779be04e7adb9f36424fe2b9b6a7d33dde8cfddd565a4ec6f41ac1c038c28fedbceda2a1e956564eb4daeded6616cbce75'
}

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rake db:sessions:create")
# ActionController::Base.session_store = :active_record_store
