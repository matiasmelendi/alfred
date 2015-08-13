##
# Mailer methods can be defined using the simple format:
#
# email :registration_email do |name, user|
#   from 'admin@site.com'
#   to   user.email
#   subject 'Welcome to the site!'
#   locals  :name => name
#   content_type 'text/html'       # optional, defaults to plain/text
#   via     :sendmail              # optional, to smtp if defined, otherwise sendmail
#   render  'registration_email'
# end
#
# You can set the default delivery settings from your app through:
#
#   set :delivery_method, :smtp => {
#     :address         => 'smtp.yourserver.com',
#     :port            => '25',
#     :user_name       => 'user',
#     :password        => 'pass',
#     :authentication  => :plain, # :plain, :login, :cram_md5, no auth by default
#     :domain          => "localhost.localdomain" # the HELO domain provided by the client to the server
#   }
#
# or sendmail (default):
#
#   set :delivery_method, :sendmail
#
# or for tests:
#
#   set :delivery_method, :test
#
# and then all delivered mail will use these settings unless otherwise specified.
#

Alfred::App.mailer :notification do

  email :correction_result do | correction |
    from "#{correction.teacher.full_name} <#{correction.teacher.email}>"
    to correction.solution.account.email
    bcc correction.teacher.email
    subject '[OBJ-1] Correccion de trabajo practico'
    locals :correction => correction
    content_type :plain
    render 'notification/correction_result.text'
  end

	email :solution_test_result do | solution |
    from "Alfred <#{ENV['MAIL_SUPPORT_ADDRESS']}>"
    to solution.account.email
    subject '[OBJ-1] Resultado pruebas del trabajo practico'
    locals :solution => solution
    content_type :plain
    render 'notification/solution_test_result.text'
	end

  email :password_has_been_reset do |email, new_password|
    from "Alfred <#{ENV['MAIL_SUPPORT_ADDRESS']}>"
    to email
    subject '[OBJ-1] Tu password ha sido restablecido'
    locals new_password: new_password
    content_type :plain
    render 'notification/password_has_been_reset.text'
  end

end
