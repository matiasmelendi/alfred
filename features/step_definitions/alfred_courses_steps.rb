And /^'(.*)' course was created$/ do |course_name|
  Factories::Course.name( course_name )
end
