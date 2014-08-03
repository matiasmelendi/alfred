module Alfred
  class App < Padrino::Application
    register Padrino::Rendering
    register Padrino::Mailer
    register Padrino::Helpers
    register Padrino::Admin::AccessControl

    enable :sessions
    enable :authentication
    enable :store_location
    set :allow_disabled_csrf, true

    ##
    # Caching support
    #
    # register Padrino::Cache
    # enable :caching
    #
    # You can customize caching store engines:
    #
    # set :cache, Padrino::Cache::Store::Memcache.new(::Memcached.new('127.0.0.1:11211', :exception_retry_limit => 1))
    # set :cache, Padrino::Cache::Store::Memcache.new(::Dalli::Client.new('127.0.0.1:11211', :exception_retry_limit => 1))
    # set :cache, Padrino::Cache::Store::Redis.new(::Redis.new(:host => '127.0.0.1', :port => 6379, :db => 0))
    # set :cache, Padrino::Cache::Store::Memory.new(50)
    # set :cache, Padrino::Cache::Store::File.new(Padrino.root('tmp', app_name.to_s, 'cache')) # default choice
    #

    ##
    # Application configuration options
    #
    # set :raise_errors, true       # Raise exceptions (will stop application) (default for test)
    # set :dump_errors, true        # Exception backtraces are written to STDERR (default for production/development)
    # set :show_exceptions, true    # Shows a stack trace in browser (default for development)
    # set :logging, true            # Logging in STDOUT for development and file for production (default only for development)
    # set :public_folder, 'foo/bar' # Location for static assets (default root/public)
    # set :reload, false            # Reload application files (default in development)
    # set :default_builder, 'foo'   # Set a custom form builder (default 'StandardFormBuilder')
    # set :locale_path, 'bar'       # Set path for I18n translations (default your_app/locales)
    # disable :sessions             # Disabled sessions by default (enable if needed)
    # disable :flash                # Disables sinatra-flash (enabled by default if Sinatra::Flash is defined)
    # layout  :my_layout            # Layout can be in views/layouts/foo.ext or views/foo.ext (default :application)
    #

    # You can configure for a specified environment like:
    #
    configure :test do
      set :delivery_method, :test
    end

    configure :development do
      set :delivery_method, :file => {
        :location => "#{Padrino.root}/tmp/emails",
      }
    end

    configure :staging, :production do
      set :delivery_method, :smtp => {
        :address              => ENV['MAIL_SERVER'],
        :port                 => ENV['MAIL_PORT'],
        :user_name            => ENV['MAIL_USER'],
        :password             => ENV['MAIL_PASSWORD'],
        :authentication       => :plain,
        :enable_starttls_auto => true
      }
    end

    #

    ##
    # You can manage errors like:
    #
    #   error 404 do
    #     render 'errors/404'
    #   end
    #
    #   error 505 do
    #     render 'errors/505'
    #   end
    #

    #set :allow_disabled_csrf, true

    set :login_page, "/accounts/login"

    access_control.roles_for :any do |role|
      role.protect '/'
      role.allow   '/accounts/login'
      role.allow   '/accounts/register'
      role.allow   '/accounts/reset_password'
      role.allow   '/accounts/new_password'
      role.allow   '/api'
      role.allow   '/health'
    end

    access_control.roles_for :teacher do |role|
      role.project_module :assignments, '/courses/.+/assignments'
      role.project_module :assignments, '/.+/gradings_report'
      role.project_module :assignment_files, '/assignment/.+/assignment_file'
      role.project_module :corrections, '/corrections'
      role.project_module :students, '/courses/.+/students'
      role.project_module :solutions, '/.+/file'
    end

    access_control.roles_for :student do |role|
      role.project_module :solutions, '/.+/file'
      role.project_module :my, '/courses/.+/my'
      role.allow '/assignment/.+/assignment_file$'
    end

    get '/' do
      render 'home/index'
    end

    get :course, :map => 'courses/:course_id' do
      set_current_course Course.first(:name => params[:course_id])
      render 'home/index'
    end

		def store_location
			session[:return_to] = request.url
		end

  end

end
