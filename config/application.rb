require File.expand_path('../boot', __FILE__)

require 'rails/all'
require 'csv'
# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module Tripshelf
  class Application < Rails::Application
    config.autoload_paths += %W(#{config.root}/lib)
    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration should go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded.

    # Set Time.zone default to the specified zone and make Active Record auto-convert to this zone.
    # Run "rake -D time" for a list of tasks for finding time zone names. Default is UTC.
    # config.time_zone = 'Central Time (US & Canada)'
    # config.time_zone = 'Kolkata'
    # config.active_record.default_timezone = :local

    # The default locale is :en and all translations from config/locales/*.rb,yml are auto loaded.
    # config.i18n.load_path += Dir[Rails.root.join('my', 'locales', '*.{rb,yml}').to_s]
    # config.i18n.default_locale = :de
    Rack::Utils.multipart_part_limit = 0
    # Do not swallow errors in after_commit/after_rollback callbacks.
    config.active_record.raise_in_transactional_callbacks = true
    $holiday_pngs_arr = {'Romantic' => 'herticon.png','Spa and Wellness' => 'rsz_spa.png','Family' => 'rsz_family.png','Budget' => 'rsz_budget.png','Adventure'=> 'rsz_adventure.png','Luxury' => 'rsz_luxury.png','Food & Drinks' => 'rsz_fastfood.png' ,'Sports' => 'rsz_sports.png','Friends' => 'rsz_friends.png'}
    $transport_pngs_arr = {'Flights' => 'cplain.png','Train' => 'c_train.png','Bus' => 'c_bus.png','Exclusive Private Vehicle' => 'c_car.png','No Transport'=> '','Others' => 'cplain.png', '' => 'cplain.png'}
    $destination_pngs_arr = {'Beaches' => 'rsz_beaches.png','Deserts' => 'rsz_deserts.png','Hills and Valleys' => 'rsz_hills.png','Rivers and Lakes' => 'rsz_rivers.png','Wildlife' => 'rsz_wildlife.png' ,'Religious' => 'rsz_religious.png' ,'Heritage' => 'rsz_heritage.png'}
  end
end
