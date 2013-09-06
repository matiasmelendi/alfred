Alfred::App.controllers :health do

  get :index do
    content_type :json
    {  :account_count => Account.count }.to_json
  end

end