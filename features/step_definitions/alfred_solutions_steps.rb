#encoding: utf-8

When /^I click submit solution for "(.*?)"$/ do |assignment_name|
  as_student_for_assignment( assignment_name, 'Entregar solución' ).click
end

When /^I click save button$/ do
    click_button( "Guardar" )
end

When /^I upload the solution's file for "(.*?)"$/ do |assignment_name|
  VCR.use_cassette("cassette_solution_for_#{assignment_name.downcase}") do
    attach_file(:solution_file, address_to("#{@student.buid}.zip"))
    click_button( "Guardar" )
  end
end

When /^I fill in link to solution$/ do
  fill_in :solution_link, :with => "http://www.mysolution.com/solution_for_assignment"
end

When(/^due date for "(.*?)" passes$/) do |assignment_name|
  assignment = Assignment.all.select{|assignment| assignment.name == assignment_name}.first
  time = assignment.deadline + 10
  Timecop.travel(time)
end

Then(/^student cannot submit a solution again for "(.*?)"$/) do |assignment_name|
  step 'I follow "Trabajos prácticos"'
  within ("#tr#{assignment_name}") do
    within("#td#{assignment_name}") do
      expect(page).to_not have_link("Entregar solución")
    end
  end
end

Then(/^student can submit a solution for "(.*?)"$/) do |assignment_name|
  step "I click submit solution for \"#{assignment_name}\""
  step 'I should see "Recordá que estás entregando fuera de fecha"'
  step 'I fill in link to solution'
  step 'I click save button'
  step 'I should see "Solution creado exitosamente"'
end

Then(/^the solution for "(.*?)" is marked as "(.*?)"$/) do |assingment_name, solution_state|
  pending # express the regexp above with the code you wish you had
end

Then /^I should see solution entry for "(.*)"$/ do |assignment_name|
  expect( page.body ).to \
    include( "Soluciones entregadas para #{assignment_name}" )
  expect { find(:xpath, "//td[contains(., \"#{@student.buid}.zip\")]") }.to_not \
    raise_error(Capybara::ElementNotFound)
end

Then /^I should (not )?see solution files attached for assignment$/ do |seeing|
  if(seeing == 'not ')
    expect( page.body ).not_to \
      include( "Archivo entregado" )  
  else
    expect( page.body ).to \
      include( "Archivo entregado" )
  end
end

Then /^I should (not )?see solution links provided for assignment$/ do |seeing|
  if(seeing == 'not ')
    expect( page.body ).not_to \
      include( "Link a entrega" )  
  else
    expect( page.body ).to \
      include( "Link a entrega" )
  end
end

And /^I follow "(.*)" for the last solution$/ do |action_name|
  query = "//a[contains( @title, \"#{action_name}\")]"
  find( :xpath, query ).click
end

And /^I click on download for last solution$/ do
  VCR.use_cassette("cassette_solution_download_#{@student.buid}") do
    find(:xpath, "//a[contains(., \"#{@student.buid}.zip\")]" ).click
  end
end

Given /^I comment "(.*?)"$/ do |comment|
  fill_in :solution_comments, :with => comment
end

Given /^a student submit solution for "(.*?)" with comment "(.*?)"$/ do |tp, comment|
  step 'I am logged in as student' 
  step 'I follow "Trabajos prácticos"'
  step "I click submit solution for \"#{tp}\""
  step "I comment \"#{comment}\""
  step "I upload the solution's file for \"#{tp}\""
end

Then /^solution should have comment: "(.*?)"$/ do |comment|
  expect(Solution.last.comments).to eql(comment)
end

When /^I see save is invalid because no file was saved$/ do
  step 'I should see "Debe seleccionar archivo"'
end

Then /^I see save is invalid because no link was provided$/ do
  step 'I should see "Debe especificar un link de entrega"'
end

Then /^I should see solution was successfully created$/ do
  step 'I should see "Solution creado exitosamente"'
end

Given /^I (do not )?see there is a field to attach a file$/ do |seeing|
  step "I should see #{seeing == 'do not ' ? 'no ' : ''}\"Archivo a entregar\""
end

Given /^I (do not )?see there is a field to write a link$/ do |seeing|
  step "I should see #{seeing == 'do not ' ? 'no ' : ''}\"Link a entrega\""
end

Given(/^A overdue solution for "(.*?)" submitted by a student$/) do |assignment_name|
#Force-modify solution submit date because upload page defaults to today
  assignment = Assignment.all.select{|assignment| assignment.name == assignment_name}.first
  overdue = Solution.all.select{|solution| solution.assignment == assignment}.first
  overdue.created_at = assignment.deadline+10
  overdue.save
end
