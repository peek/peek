Peek::Railtie.routes.draw do
  get '/results' => 'results#show', as: :results
end
