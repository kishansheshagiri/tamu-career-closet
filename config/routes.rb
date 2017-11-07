Rails.application.routes.draw do

  # match '/rentals/viewActive' => 'rentals#view_active_user', via: :get
  # match '/rentals/viewCheckedOut' => 'rentals#view_checkedOut', via: :get
  # match '/rentals/activeUsersAndCheckedOutApparels' => 'rentals#num_active_users_and_checked_out', via: :get
  # match '/apparels/getSizes' => 'apparels#get_sizes', via: :get
  # match '/students/new' => 'students#create', via: :post
  # match '/students/delete' => 'students#destroy', via: :get
  # match '/students/show' => 'students#show', via: :get
  # match '/students/update' => 'students#update', via: :post

  # get "rentals/pending_returnsAndDefaulters", to: "rentals#pending_returnsAndDefaulters", as: "pendingreturns",:defaults => { :format => 'json' }
  # get "rentals/assignsuits/:studentUIN/:apparelId", to: "rentals#assignSuits",as: "assignsuits",:default=>{:format=>'json'}
  # resources :constants
  # resources :rentals
  # resources :apparels
  # resources :students

  root 'students#home'
  #Login and Registration API
  post 'auth/login', to: 'authentication#authenticate'
  post 'signup', to: 'users#create'
  # root 'rentals#index'
  # namespace the controllers without affecting the URI
  scope module: :v1, constraints: ApiVersion.new('v1', true) do
    #Rentals API  
    get 'rentals', to: 'rentals#index'
    get 'rentals/activeusers', to: 'rentals#view_active_user'
    get 'rentals/checkedout', to: 'rentals#view_checkedOut'
    get 'rentals/checkedactive', to: 'rentals#num_active_users_and_checked_out'
    get 'rentals/returns', to: 'rentals#pending_returns'
    get 'rentals/defaulters', to: 'rentals#pending_returnsAndDefaulters'
    post 'rentals/assign', to: 'rentals#assignSuits'
    post "rentals/receiveSuits", to: "rentals#receiveSuits",as: "receiveSuits",:default=>{:format=>'json'}
    get "sendPendingEmails", to: "rentals#sendPendingEmails",:default=>{:format=>'json'}
    get "sendOverDueEmails",  to: "rentals#sendOverDueEmails",:default=>{:format=>'json'}
    get "getConstants", to: "constants#showConstants",:default=>{:format=>'json'}
    post "updateConstants", to:"constants#updateConstant",:default=>{:format=>'json'}
    get 'rentals/list_reports', to: 'rentals#list_reports'
    get 'rentals/new_report', to: 'rentals#new_report', defaults: { format: :csv }
    get 'rentals/create_report', to: 'rentals#create_report', defaults: { format: :csv }
    get 'rentals(/:id)', to: 'rentals#show'
    post 'rentals', to: 'rentals#create'
    put 'rentals/:id', to: 'rentals#update'
    delete 'rentals/:id', to: 'rentals#destroy'

    #Students API
    get 'students', to: 'students#index'
    get 'students(/:id)', to: 'students#show'
    post 'students', to: 'students#create'
    put  'students/:id', to: 'students#update'
    delete  'students/:id', to: 'students#destroy'
    
    #Apparels API
    get 'apparels', to: 'apparels#index'
    get 'apparels/bysize/:size', to: 'apparels#bysize'
	get 'apparels/bysizeandstock/:size/:stock', to: 'apparels#bysize_and_stock'
	get 'apparels/getcheckedoutstock', to: 'apparels#get_stock', :defaults => { :stock => 1 }
	get 'apparels/getavailablestock', to: 'apparels#get_stock', :defaults => { :stock => 0 }
    get 'apparels/getsizes', to: 'apparels#get_sizes'
    get 'apparels(/:id)', to: 'apparels#show'
    post 'apparels', to: 'apparels#create'
    put  'apparels/:id', to: 'apparels#update'
    delete  'apparels/:id', to: 'apparels#destroy'

    resources :constants
    resources :rentals
    resources :apparels
    resources :students
  end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html


end
