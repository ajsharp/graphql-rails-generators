require "rails/generators/named_base"
require_relative 'gql_generator_base'

module Gql
  class MutationGenerator < Rails::Generators::NamedBase
    include GqlGeneratorBase
    remove_argument :name # remove name base default arg

    argument :mutation_prefix, type: :string
    argument :model_name, type: :string
    source_root File.expand_path('../templates', __FILE__)

    # hack to keep NamedBase helpers working
    def name
      model_name
    end
  
    def mutation
      file_name = "#{mutation_prefix}_#{singular_name}"
      template('model_mutation.rb', "app/graphql/mutations/#{class_path.join('/')}/#{file_name.underscore}.rb")
      insert_into_file("app/graphql/types/mutation_type.rb", after: "  class MutationType < Types::BaseObject\n") do
        "\t\tfield :#{file_name.camelcase(:lower)}, mutation: Mutations::#{prefixed_class_name(mutation_prefix)}\n"
      end
    end
  end
  
end