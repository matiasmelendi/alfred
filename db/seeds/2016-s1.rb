course = Course.new
course.name = '2016-1'
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


gabriel = Account.new_teacher({:name => 'Gabriel',
                               :surname => 'Gonzalez',
                               :password => 'Passw0rd!',
                               :password_confirmation => 'Passw0rd!',
                               :buid => '09',
                               :email => 'gabrielnicolasgonzalez@gmail.com'})
gabriel.courses << course
gabriel.save


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


juan = Account.new_teacher({:name => 'Juan',
                               :surname => 'Escalada',
                               :password => 'Passw0rd!',
                               :password_confirmation => 'Passw0rd!',
                               :buid => '10',
                               :email => 'jf.escalada92@gmail.com'})
juan.courses << course
juan.save


maxi = Account.new_teacher({:name => 'Maximiliano',
                               :surname => 'Diaz',
                               :password => 'Passw0rd!',
                               :password_confirmation => 'Passw0rd!',
                               :buid => '11',
                               :email => 'diazmaxi@gmail.com'})
maxi.courses << course
maxi.save


agus = Account.new_teacher({:name => 'Agustin',
                               :surname => 'Garcia Smith',
                               :password => 'Passw0rd!',
                               :password_confirmation => 'Passw0rd!',
                               :buid => '15',
                               :email => 'garciasmithagustin@gmail.com'})
agus.courses << course
agus.save
