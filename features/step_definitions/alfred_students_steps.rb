And /^I enroll in '(.*)'$/ do |course_name|
  @student.enrolls( Course.find_by_name(course_name) )
end

Then /^I am enrolled in '(.*)'$/ do |course_name|
  @student.is_enrolled?( Course.find_by_name(course_name) )
end
