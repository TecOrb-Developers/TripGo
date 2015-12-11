# Be sure to restart your server when you modify this file.

#Rails.application.config.session_store :cookie_store, key: '_tripshelf_session'
Tripshelf::Application.config.session_store :active_record_store, :key => '_tripshelf_session'
