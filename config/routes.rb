TapWaterObserver::Application.routes.draw do
  root "page#index"
  get "send_mail" => "page#send_mail"
end
