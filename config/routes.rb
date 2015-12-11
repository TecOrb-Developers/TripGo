Rails.application.routes.draw do

  # ActiceAdmin routes
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  
  get 'approve_user/:id' => 'users#approve_user' ,:as => 'approve_user'
  get 'approve_partner/:id' => 'users#approve_partner' ,:as => 'approve_partner'
  get 'approve_package/:id' => 'packages#approve_package',:as => 'approve_package'
  get '/admin/send_mail' => 'admin/send_mail', :as => :admin_send_email
  post 'users_send_mail' => 'users#users_send_mail_by_admin'
  post 'terms_conditions' => 'page_contents#terms_conditions'
  post 'aboutus' => 'page_contents#about_us'
  post 'create-team' => 'page_contents#team'
  post 'policy' => 'page_contents#policy'
  post 'contact' => 'page_contents#contact'
  put '/recommended_side' => 'packages#recommended_side'

  # Normal routes 
  devise_for :users, :controllers => {:passwords => "passwords"}
  devise_scope :user do
   authenticated :user do
     get   'dashboard/mainboard' => 'dashboard#mainboard', as: 'mainboard'
     patch '/update_password'=> 'users#update_password', as: 'update_password'
     get  '/menu_board'=> 'dashboard#menu_board', as: 'menu_board'
     get  '/edit_account/:id' => 'users#edit_suplier', as: 'edit_suplier'
     patch '/update_supplier_account' => 'users#update_supplier_account',as: 'update_supplier_account'
     
     resources :packages do 
      member do
        post 'duplicate_package'
      end
    end
        # transports routes
        get  '/edit/:id' => 'transports#edit', as: 'edit_transport'
        patch  '/update/:id' => 'transports#update', as: 'update_transport'
        # City transports routes
        get '/edit_city_transport/:id' => 'city_transports#edit_city_transport', as: 'edit_city_transports'
        patch '/update_city_transport/:id' => 'city_transports#update', as: 'update_city_transports'
        # Hotels routes
        get '/add_hotel/:id' => 'hotels#add_hotel', as: 'edit_hotel'
        patch '/update_hotel/:id' => 'hotels#update_hotel', as: 'update_hotel'
        # inclusion routes
        get '/edit_inclusion/:id' => 'inclusions#edit_inclusion', as: 'edit_inclusion'
        patch '/update_inclusion/:id' => 'inclusions#update_inclusion', as: 'update_inclusion'
        # package filter path 
        get  '/packages-filter' => 'packages#packages_filter'
        # sight_scenes routes
        get  '/sight_sences_edit/:id' => 'sight_scenes#edit', as: 'edit_sight_scenes'
        patch  '/sight_scenes_update/:id' => 'sight_scenes#update', as: 'update_sight_scenes'
        # itineraries routes
        get  '/itineraries_edit/:id' => 'itineraries#edit', as: 'edit_itineraries'
        patch  '/itineraries_update/:id' => 'itineraries#update', as: 'update_itineraries'
        # meals routes
        get  '/meals_edit/:id' => 'meals#edit', as: 'edit_meals'
        patch  '/meals_update/:id' => 'meals#update', as: 'update_meals'
        # crms routes
        resources :crms, :only=> [:index]
        # crms filter path 
        get  '/crms-filter' => 'crms#crms_filter'
        post  '/crms-mark-as' => 'crms#mark_as', as: 'crms_mark_as' #done
        post  '/crms-export-csv' => 'crms#export_csv', as: 'export_csv_action' #done
        delete  '/delete-selected' => 'crms#delete_selected', as: 'delete_selected_action'
        post  '/csv-as-email' => 'crms#csv_as_email', as: 'csv_as_email_action'
        post  '/assigned_to' => 'crms#assign' , as: 'crm_assigned'
        post  '/inventory' => 'packages#inventory' , as: 'package_inventory'
        post  '/status-update' => 'crms#status_update', as: 'status_update_action'
        #wishlist
        post  '/add-to-wishlist' => 'home#add_to_wishlist'
        delete  '/delete-wishlist' => 'home#delete_wishlist'

      end
    end
    get 'home/find_city'
    get  'search' => 'home#search', as: 'home_search'
    get 'about_us' => 'home#about_us',as: 'about_us'
    get 'become_our_partner' => 'home#become_our_partner',as: 'become_our_partner'
    get 'become_partner' => 'home#become_partner',as: 'become_partner'
    get 'career' => 'home#career',as: 'career'
    get 'terms_and_condition' => 'home#terms_condition', as: 'terms_and_condition'
    get 'team' => 'home#team', as: 'team'
    get 'website' => 'home#website', as: 'website'
    get 'contact_us' => 'home#contact_us', as: 'contact_us'
    get 'our_partner' => 'home#our_partner', as:'our_partner'
    get 'affiliate_program' => 'home#affiliate_program', as:'affiliate_program'
    get 'view_on_map/:id' => 'home#view_on_map', as: 'view_on_map'
    get 'partner_model' => 'home#partner_model', as:'partner_model'
    post 'enquiry' => 'home#enquiry',as:'enquiry'
    get '/get-enquiry-detail' => 'home#get_enquiry_detail'
    post 'add-to-comparision' => 'home#add_remove_comparision'
    get 'is-valid-to-compare' => 'home#is_valid_to_compare'
    post 'complaint' => 'home#complaint', as:'complaint'
    get  '/supplier_detail/:id' => 'users#supplier_detail', as: 'supplier_detail'
    get  '/more_packages/:id' => 'users#more_packages', as: 'more_packages'
    
    # get 'home/change_places'
    unauthenticated do
     # root 'home#index'
     # get 'home/index'
     get 'users/suplier_sign_up'
     post 'users/create_supplier_account'
     post 'users/create_consumer_account'
     post 'users/check_email'
     get "/auth/:provider/callback" => "social_authentications#social_login"
   end
   root 'home#index'
   get '/wishlist' => 'home#wishlist', as: 'wishlist'
   get '/comparision' => 'home#comparision', as: 'comparision'
   get 'inclusions/:id' => "packages#inclusions", as: 'inclusion'
   #notifications
   resources :notifications, :only=> [:index]

 end


