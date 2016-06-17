Rails.application.routes.draw do

  root to: "home#index"

  get 'marika', to: 'admin/dashboard#data_chart'
  get 'admin', to: 'admin/dashboard#data_chart'

  namespace :admin do
    get 'data_chart', to: 'dashboard#data_chart'
    get 'site_chart', to: 'dashboard#site_chart'
    get 'preferences', to: 'preferences#preferences'
    patch 'preferences_update', to: 'preferences#update'

    get 'projects/new_participants', to: 'projects#new_participants'
    patch 'projects/create_participants', to: 'projects#create_participants'

    resources :projects, except: [:show] do
      post 'participations.json/datatables', to: 'participations#index'
      get 'new_from_db', to: 'participations#new_from_db'
      post 'create_from_db', to: 'participations#create_from_db'
      patch 'create_multiple', to: 'participations#create_multiple'
      resources :participations
    end

    get 'members/invites_index', to: 'members#invites_index'
    get 'members/invite', to: 'members#invite'
    post 'members/:id/resend_invitation', to: 'members#resend_invitation', as: 'member/resend_invitation'
    get 'members/student_members_index', to: 'members#student_members_index'

    get 'member/destroy_check_for_publications', to: 'members#destroy_check_for_publications'
    delete 'member/:id/destroy_with_publications', to: 'members#destroy_with_publications'
    resources :members do
      post 'personal_websites.json/datatables', to: 'personal_websites#index'
      resources :personal_websites
    end

    get 'publication/check_if_any_members', to: 'publications#check_if_any_members'
    resources :publications, except: [:show] do
      post 'authors.json/datatables', to: 'authors#index'
      get 'new_from_db', to: 'authors#new_from_db'
      post 'create_from_db', to: 'authors#create_from_db'
      patch 'create_multiple', to: 'authors#create_multiple'
      post 'authors/delete_publication', to: 'authors#delete_publication'
      #patch 'authors/:id/edit_priority', to: 'authors#edit_priority'
      resources :authors, except: :create
    end

    resources :conferences, except: [:destroy] do
      resources :authors
    end

    resources :journals, except: [:destroy] do
      resources :authors
    end

    resources :people, except: [:show, :create], path: "authors"

    resources :participants, except: [:new,:show, :create]

    resources :news_events

    resources :website_templates

    get 'members/:id/change_password', to: 'members#change_password', as: :edit_admin_member_change_password
    post 'projects.json/datatables', to: 'projects#index'
    post 'participants.json/datatables', to: 'participants#index'
    post 'members.json/datatables', to: 'members#index'
    post 'members/student_members_index.json/datatables', to: 'members#student_members_index'
    post 'members/invites_index.json/datatables', to: 'members#invites_index'
    post 'news_events.json/datatables', to: 'news_events#index'
    post 'publications.json/datatables', to: 'publications#index'
    post 'conferences.json/datatables', to: 'conferences#index'
    post 'journals.json/datatables', to: 'journals#index'
    post 'authors.json/datatables', to: 'people#index'
    post 'website_templates.json/datatables', to: 'website_templates#index'
  end

  mount Judge::Engine => '/judge'

  get 'about', to: 'home#about'

  resources :publications, only:[:index,:show]

  get 'contact_us', to: 'home#contact'

  get 'news', to: 'home#newsevents'

  get 'projects', to: 'home#projects'

  resources :members, only: [:index, :update, :edit]
  #get 'edit_profile/:id', to: 'members#edit_profile'

  devise_for :members, :controllers => { registrations: 'registrations', invitations: 'invitations' }



  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  # root 'welcome#index'

  # Example of regular route:
  #   get 'products/:id' => 'catalog#view'

  # Example of named route that can be invoked with purchase_url(id: product.id)
  #   get 'products/:id/purchase' => 'catalog#purchase', as: :purchase

  # Example resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Example resource route with options:
  #   resources :products do
  #     member do
  #       get 'short'
  #       post 'toggle'
  #     end
  #
  #     collection do
  #       get 'sold'
  #     end
  #   end

  # Example resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Example resource route with more complex sub-resources:
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', on: :collection
  #     end
  #   end

  # Example resource route with concerns:
  #   concern :toggleable do
  #     post 'toggle'
  #   end
  #   resources :posts, concerns: :toggleable
  #   resources :photos, concerns: :toggleable

  # Example resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end
end
