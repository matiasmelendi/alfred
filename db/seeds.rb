# Seed add you the ability to populate your db.
# We provide you a basic shell for interaction with the end user.
# So try some code like below:
#
#   name = shell.ask("What's your name?")
#   shell.say name
#


course = Course.new
course.name = '2015-2'
course.active = true
course.save

maximo = Account.new_teacher({:name => 'Maximo',
                               :surname => 'Prieto',
                               :password => 'Passw0rd!',
                               :password_confirmation => 'Passw0rd!',
                               :buid => '01',
                               :email => 'maximoprieto@gmail.com'})
maximo.courses << course
maximo.save

nahuel = Account.new_teacher({:name => 'Nahuel',
                               :surname => 'Garbezza',
                               :password => 'Passw0rd!',
                               :password_confirmation => 'Passw0rd!',
                               :buid => '02',
                               :email => 'n.garbezza@gmail.com'})
nahuel.courses << course
nahuel.save

nacho = Account.new_teacher({:name => 'Juan Ignacio',
                              :surname => 'Vidal',
                              :password => 'Passw0rd!',
                              :password_confirmation => 'Passw0rd!',
                              :buid => '03',
                              :email => 'magovidal@gmail.com'})
nacho.courses << course
nacho.save

matias = Account.new_teacher({:name => 'Matias',
                              :surname => 'Melendi',
                              :password => 'Passw0rd!',
                              :password_confirmation => 'Passw0rd!',
                              :buid => '04',
                              :email => 'm.f.melendi@gmail.com'})
matias.courses << course
matias.save

angeles = Account.new_teacher({:name => 'Angeles',
                                :surname => 'Tella Arena',
                                :password => 'Passw0rd!',
                                :password_confirmation => 'Passw0rd!',
                                :buid => '05',
                                :email => 'angeles.tellaarena@gmail.com'})
angeles.courses << course
angeles.save

alvaro = Account.new_teacher({:name => 'Alvaro',
                              :surname => 'Piorno',
                              :password => 'Passw0rd!',
                              :password_confirmation => 'Passw0rd!',
                              :buid => '06',
                              :email => 'alvaropiorno100@gmail.com'})
alvaro.courses << course
alvaro.save

gaston = Account.new_teacher({:name => 'Gaston',
                              :surname => 'Caruso',
                              :password => 'Passw0rd!',
                              :password_confirmation => 'Passw0rd!',
                              :buid => '07',
                              :email => 'gstn.caruso@gmail.com'})
gaston.courses << course
gaston.save

sol = Account.new_teacher({:name => 'Sol',
                              :surname => 'Gomez',
                              :password => 'Passw0rd!',
                              :password_confirmation => 'Passw0rd!',
                              :buid => '08',
                              :email => 'solxi.gz@gmail.com'})
sol.courses << course
sol.save


caloventhor = Account.new_teacher({:name => 'Julian',
                              :surname => 'Calvento',
                              :password => 'Passw0rd!',
                              :password_confirmation => 'Passw0rd!',
                              :buid => '10',
                              :email => 'juliancalvento@gmail.com'})
caloventhor.courses << course
caloventhor.save

camila = Account.new_teacher({:name => 'Camila',
                              :surname => 'Garcia',
                              :password => 'Passw0rd!',
                              :password_confirmation => 'Passw0rd!',
                              :buid => '11',
                              :email => 'camilagarcia.113@gmail.com'})
camila.courses << course
camila.save

oscar = Account.new_teacher({:name => 'Oscar',
                              :surname => 'Lescano',
                              :password => 'Passw0rd!',
                              :password_confirmation => 'Passw0rd!',
                              :buid => '12',
                              :email => 'oscar_master93@hotmail.com'})
oscar.courses << course
oscar.save

manuel = Account.new_teacher({:name => 'Manuel',
                              :surname => 'Martin',
                              :password => 'Passw0rd!',
                              :password_confirmation => 'Passw0rd!',
                              :buid => '13',
                              :email => 'martinmanuel2704@gmail.com'})
manuel.courses << course
manuel.save

facundo = Account.new_teacher({:name => 'Facundo',
                              :surname => 'Vigo',
                              :password => 'Passw0rd!',
                              :password_confirmation => 'Passw0rd!',
                              :buid => '14',
                              :email => 'facundovigo@gmail.com'})
facundo.courses << course
facundo.save


gabriel = Account.new_teacher({:name => 'Gabriel',
                               :surname => 'Gonzalez',
                               :password => 'Passw0rd!',
                               :password_confirmation => 'Passw0rd!',
                               :buid => '09',
                               :email => 'gabrielnicolasgonzalez@gmail.com'})
gabriel.courses << course
gabriel.save

=begin
email     = shell.ask "Which email do you want use for logging into admin?"
password  = shell.ask "Tell me the password to use:"

shell.say ""

account = Account.create(:email => email, :buid => "root", :name => "Foo", :surname => "Bar", :password => password, :password_confirmation => password, :role => "admin")

if account.valid?
  shell.say "================================================================="
  shell.say "Account has been successfully created, now you can login with:"
  shell.say "================================================================="
  shell.say "   email: #{email}"
  shell.say "   password: #{password}"
  shell.say "================================================================="
else
  shell.say "Sorry but some thing went wrong!"
  shell.say ""
  account.errors.full_messages.each { |m| shell.say "   - #{m}" }
end

shell.say ""
=end
