Rails.application.routes.draw do
  get 'welcome/index'
  post '/login',to:'login#login'
   put '/update_order',to:'task_lists#order'
   put '/tasks_order', to:'tasks#order'
   put '/subtasks_order', to:'subtasks#order'
   put '/complete_all_subtask',to:'subtasks#complete_all'
   post '/projects/:project_id/project_actors_group', to:'project_actors#create_by_group'
   get '/projects/:project_id/statics',to:'tasks#statics'
  resources :articles do
  resources :comments
  end
  resources:users, shallow:true do
    resources :projects
  end
  resources:projects, shallow:true do
    resources :project_actors
    resources :task_lists  
    resources :agendas
    resources :shares
  end
  #project_actors
  resources :project_actors 
  #task_lists
  resources:task_lists, shallow:true do
    resources :tasks 
  end
  resources:tasks, shallow:true do
    resources :task_actors 
    resources :subtasks
    resources :tags
    resources :task_comments
  end
    resources :task_actors 
    resources :subtasks
    resources :tags
  #agendas
  resources:agendas, shallow:true do
    resources :agenda_actors
  end
  resources :agenda_actors
  #shares
  resources:shares, shallow:true do
    resources :share_comments
  end
  resources :share_comments
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
