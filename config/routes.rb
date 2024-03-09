Rails.application.routes.draw do
  devise_for :students, path: 'users', controllers: {
    sessions: 'students/sessions',
    registrations: 'students/registrations'
  }, path_names: {
      sign_in: 'login',
      sign_out: 'logout',
      registration: 'signup'
    }

  resources :students
  resources :study_groups, path: 'classes'

  resources :schools
  if Rails.env.development? || Rails.env.test?
    mount Railsui::Engine, at: "/railsui"
  end

  get 'schools/:school_id/classes/:class_id/students', to: 'school_classes/students#index', as: 'school_class_students'
  get 'schools/:id/classes', to: 'schools#show'
  post 'schools/:school_id/classes/:class_id/students', to: 'school_classes/students#create', as: 'new_school_class_student'

  root "students#index"
end
