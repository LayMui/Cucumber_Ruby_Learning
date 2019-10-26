task default: [:unit_tests, :core_acceptance_tests, :web_acceptance_tests]

task :unit_tests do
  sh "rspec"
end

task :core_acceptance_tests do
  sh "cucumber"
end

task :web_acceptance_tests do
  sh "shouty_test_depth=web cucumber --tags @high-impact,@high-risk"
end
