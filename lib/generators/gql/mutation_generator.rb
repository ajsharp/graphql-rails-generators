module Gql
  class MutationGenerator < Rails::Generators::Base
    argument :mutation_prefix, type: :string
    argument :model_name, type: :string
    source_root File.expand_path('../templates', __FILE__)
  
    def mutation
      file_name = "#{mutation_prefix}#{model_name}"
      template('model_mutation.rb', "app/graphql/mutations/#{file_name.underscore}.rb")
    end
  end
  
end