gemspec = eval(File.read("graphql-rails-generators.gemspec"))

task :build => "#{gemspec.full_name}.gem"

file "#{gemspec.full_name}.gem" => gemspec.files + ["graphql-rails-generators.gemspec"] do
  system "gem build graphql-rails-generators.gemspec"
  system "git tag v#{GraphqlRailsGenerators::VERSION}"
end