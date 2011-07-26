# Be sure to restart your server when you modify this file.

# Your secret key for verifying cookie session data integrity.
# If you change this key, all old sessions will become invalid!
# Make sure the secret is at least 30 characters and all random, 
# no regular words or you'll be exposed to dictionary attacks.
ActionController::Base.session = {
  :key         => '_arcanis_counter_session',
  :secret      => 'c4ef7e597a54ead0ce7bc4dbcb91bb51dbbe30573fb4e3497f250fe322f2ebb5c36feb1a94f27e6b17236b67ff18131389a8ae13ab7c0f5d7100a0d173e182ad'
}

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rake db:sessions:create")
ActionController::Base.session_store = :active_record_store
