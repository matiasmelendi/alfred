# Seed add you the ability to populate your db.
# We provide you a basic shell for interaction with the end user.
# So try some code like below:
#
#   name = shell.ask("What's your name?")
#   shell.say name
#

# Teacher creation
teacher = Account.new_teacher({:name => 'teacher_name', 
															 :surname => 'teacher_surname',
															 :password => 'Passw0rd!',
															 :password_confirmation => 'Passw0rd!',
															 :buid => '12345', 
															 :email => 'teacher@test.com'})

Account.new_teacher({ :name => 'yoda', :surname => '',
                      :password => 'foobar', 
                      :password_confirmation => 'foobar',
										  :buid => '00001', 
											:email => 'yoda@test.com'}).save

Account.new_teacher({ :name => 'obi-wan', :surname => '',
                      :password => 'foobar', 
                      :password_confirmation => 'foobar',
										  :buid => '00002', 
											:email => 'obi@test.com'}).save

Account.new_teacher({ :name => 'lord', :surname => '',
                      :password => 'foobar', 
                      :password_confirmation => 'foobar',
										  :buid => '00003', 
											:email => 'lord@test.com'}).save


# Students creation
student = Account.new_student({:name => 'student_name', 
															 :surname => 'student_surname',
															 :password => 'Passw0rd!', :tag => 'mie',
															 :password_confirmation => 'Passw0rd!',
															 :buid => '12346',
															 :tag => 'mie',
															 :email => 'student@test.com'})

s1 = Account.new_student({:name => 's1_name', :surname => 's1_surname',
															 :password => 'foobar', :tag => 'mie',
															 :password_confirmation => 'foobar',
															 :buid => '10001', :email => 's1@test.com'})

s2 = Account.new_student({:name => 's2_name', :surname => 's2_surname',
															 :password => 'foobar', :tag => 'mie',
															 :password_confirmation => 'foobar',
															 :buid => '10002', :email => 's2@test.com'})

recurrent = Account.new_student({:name => 'recurrent_name', :surname => 'recurrent_surname',
															 :password => 'foobar', :tag => 'mie',
															 :password_confirmation => 'foobar',
															 :buid => '10003', :email => 'recurrent@test.com'})


course = Course.create( :name => '2012-2', :active => true )
teacher.courses << course
teacher.save

[student, s1, s2, recurrent].each do |s|
  s.courses << course
  s.save
end


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
