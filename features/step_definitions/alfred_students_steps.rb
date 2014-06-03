And /^I click on '(.*)'$/ do |course_name|
  find( '#account_active_course' ).set(true)
end

Then /^I am enrolled in '(.*)'$/ do |course_name|
  course = Course.find_by_name(course_name)
  expect( @student.reload.is_enrolled?(course)).to be true
end
