Dummy::Application.routes.draw do
  mount Peek::Railtie => 'peek'

  get '/enabled' => 'home#enabled'
  get '/disabled' => 'home#disabled'

  root to: 'home#enabled'
end
