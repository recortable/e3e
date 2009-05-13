# Be sure to restart your server when you modify this file.

# Your secret key for verifying cookie session data integrity.
# If you change this key, all old sessions will become invalid!
# Make sure the secret is at least 30 characters and all random, 
# no regular words or you'll be exposed to dictionary attacks.
ActionController::Base.session = {
  :key         => '_e3e_session',
  :secret      => 'aae280b39819881cfb7ced138c048c2ee29eed19e8555c7c118e2146d727ef0498643614a5be0fe724a701d0bddbbe329c79ef1caf117cc41ea382fa55f788bf'
}

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rake db:sessions:create")
# ActionController::Base.session_store = :active_record_store
