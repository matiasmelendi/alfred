Alfred::App.controllers :health do

  get :index do
    return "Account.count: #{Account.count}"
  end

  get :version do
    ENV['version']
  end

end
