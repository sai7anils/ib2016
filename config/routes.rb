Rails.application.routes.draw do

  resources :orders

  resources :attachments
  root to: 'home#index'

  namespace :home do
    get 'entrepreneur'
    get 'loadmoreentrepreneur'
    get 'loadmoreinvestor'
    get 'loadmorestartup'
    get 'loadmoreevents'
    get 'terms'
    get 'behindIT'
    get 'howitwork'
  end

  devise_for :users, path: 'user',
  module: :user,
    path_names: {
      sign_up: :signup,
      sign_in: :login,
      sign_out: :logout
  }
  devise_scope :user do
    get 'user/logout' => 'user/sessions#destroy'
    get 'user/my_acount' => 'user/registrations#edit_password', as: 'my_acount'
    post 'user/update_password' => 'user/registrations#update_password'
    get 'user/notification' => 'user/registrations#notification', as: 'notification'
    get 'user/message' => 'user/registrations#message', as: 'message'
    get 'user/unread' => 'user/registrations#unread', as:'unread'
    get 'user/loadmorenotification' => 'user/registrations#loadmorenotification', as:'loadmorenotification'
    get 'user/my_events' => 'user/events#my_events'
    get 'user/my_ideas' => 'user/ideas#my_ideas'
  end
  resources :users

  namespace :api do
    get 'states/:country', to: 'location#states'
    get 'cities/:country/:state', to: 'location#cities'
    get 'subregion_options', to: 'location#subregion_options'
    get 'event_subregion_options', to: 'location#event_subregion_options'
    get 'idea/comments/:id/:limit', to: 'idea#comments'
    get 'notifications/all', to: 'notification#index'
    get 'notifications/loadmore', to: 'notification#loadmore'
    get 'notifications/seen', to: 'notification#seen'
    get 'idea/like/:id', to: 'idea#like_page'
    get 'idea/rating/:id', to: 'idea#rating_page'
    get 'idea/likes/:id', to: 'idea#likes'
    get 'idea/user_idea_liked/:id', to: 'idea#user_idea_liked'
    post 'idea/intrested', to: 'idea#intrested'
    post 'idea/favorite', to: 'idea#favorite'
    post 'idea/deal', to: 'idea#deal'
    get 'messages/all', to: 'message#index'
    get 'messages/loadmore', to: 'message#loadmore'
    get 'messages/seen', to: 'message#seen'
  end

  namespace :user do
    get 'myacount'
    get 'notification'
    get 'startupdetail'
    get 'investordetail'

    resources :business_ideas do
      get :load_more, on: :collection
    end
    resources :fund_startups, path: "funds"

    resources :ideas do
      collection do
        post '/comment' => 'ideas#create_comment'
        post '/reply' => 'ideas#create_reply'
        post '/like' => 'ideas#like'
        post '/update_comment' => 'ideas#update_comment'
        get '/load_more' => 'ideas#load_more'
        post '/like_comment' => 'ideas#like_comment'
        post '/replied_reply' => 'ideas#create_replied_reply'
        get 'detailpage'
        get 'upcomingevent'
        get 'createvent'
        get 'closeidea'
        get 'businessdetail'
        get 'businessidea'
        get 'message'
        get 'expand_messages' => 'ideas#expand_messages'
        get 'reply_message' => 'ideas#reply_message'
      end
    end

    resources :entrepreneurs do
      collection do
        get '/load_more' => 'entrepreneurs#load_more'
      end
    end

    resources :startups do
      collection do
        get '/load_more' => 'startups#load_more'
        get '/fund/new' => 'startups#fund_new'
        get '/fund/detail' => 'startups#fund_show'
        get '/funds' => 'startups#funds'
      end
    end

    resources :investors do
      member do
        get :confirm_email
      end

      collection do
        get '/load_more' => 'investors#load_more'
        post '/identities/create' => 'investors#identity_create'
        get '/identities/new' => 'investors#identity_new'
        post '/messages/create' => 'investors#message_create'
        get '/messages/new' => 'investors#message_new'
        get :my_favourites
        get :load_more_business
      end
    end

    resources :events do
      collection do
        get '/new' => 'events#new'
        post '/create' => 'events#create'
        get '/load_more_events' => 'events#load_more_events'
      end
    end

  end

  get 'entrepreneurs' => 'user/entrepreneurs#index'
  get 'entrepreneur/:id', to: 'user/entrepreneurs#show', as: 'entrepreneur'
  get 'investor/:id', to: 'user/investors#show', as: 'investor'
  get 'startup/:id', to: 'user/startups#show', as: 'startup'
  get 'investors' => 'user/investors#index'
  get 'startups' => 'user/startups#index'
  post '/rate' => 'rater#create', :as => 'rate'

  namespace :admin do
    root 'home#index'
    resources :user do
      collection do
        get :entrepreneurs
        get :investors
        get :startups
      end
    end
    resources :ideas
    resources :ajax
    resources :setting
    resources :events
    resources :business_ideas, only: [:index, :show, :destroy]
    resources :transactions, only: [:index, :show, :destroy]
    resources :orders, only: [:index, :show, :destroy]
    delete '/delete_user/:id', to: 'ajax#delete_user', as: 'ajax_delete_user'
  end

  get 'lang/:locale', to: 'change_locale#change', as: 'change_lang'

end
