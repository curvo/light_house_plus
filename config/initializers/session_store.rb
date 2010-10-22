# Be sure to restart your server when you modify this file.

# Your secret key for verifying cookie session data integrity.
# If you change this key, all old sessions will become invalid!
# Make sure the secret is at least 30 characters and all random, 
# no regular words or you'll be exposed to dictionary attacks.
ActionController::Base.session = {
  :key         => '_lighthouseplus_session',
  :secret      => '7f64fbc59586f219d5e1063a874ce78c7ef566bf5ce1bf3bd332a9a1c0797b9b8ca1c4eba781814c0ebe8a84c53dfca6f07af28b9a66ab2864fbc92548599b59'
}

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rake db:sessions:create")
# ActionController::Base.session_store = :active_record_store
