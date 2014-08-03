Alfred::App.controllers :accounts do
  delete :logout do
    set_current_account(nil)
    set_current_course(nil)
    redirect '/'
  end

  get :login do
    render 'accounts/login'
  end

  post :login do
    if account = Account.authenticate(params[:email], params[:password])
      set_current_account(account)
      if account.is_student?
        redirect_back_or_default("courses/#{current_course.name}/students/me")
      else
        redirect_back_or_default('/')
      end
    else
      params[:email], params[:password] = h(params[:email]), h(params[:password])
      flash[:error] = pat('login.error')
      redirect url(:accounts, :login)
    end
  end

  get :register do
    @title = pat(:new_title, :model => 'account')
    @account = Account.new
    render 'accounts/register'
  end

  post :register do
    @account = Account.new_student(params[:account])
    @account.courses << Course.active
    if @account.save
      flash[:success] = t(:account_created)
      redirect('/accounts/login')
    else
      flash.now[:error] = t(:account_creation_error)
      render 'accounts/register'
    end
  end

  get :reset_password do
    if current_account
      redirect '/'
    end

    @account = Account.new
    render 'accounts/reset_password'
  end

  post :reset_password do
    if current_account
      redirect '/' and return
    end

    if params[:account].blank? || params[:account][:email].blank?
      flash.now[:error] = t('accounts.reset_password.email_required')
    else
      @account = Account.first(email: params[:account][:email])
      flash.now[:error] = t('accounts.reset_password.cannot_find_account_with_email', email: params[:account][:email]) if !@account
    end

    if flash.now[:error]
      @account = Account.new
      render 'accounts/reset_password'
    else
      @account.reset_password
      flash.now[:success] = t('accounts.reset_password.sent_on_email')
      redirect url(:accounts, :login)
    end
  end
end
