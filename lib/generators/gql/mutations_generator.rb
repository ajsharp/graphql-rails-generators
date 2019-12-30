require "rails/generators/named_base"
require_relative 'gql_generator_base'

module Gql
  class MutationsGenerator < Rails::Generators::NamedBase
    include GqlGeneratorBase
    source_root File.expand_path('../templates', __FILE__)
    desc "Generate create, update and delete generators for a model."

    def mutations
      insert_into_file("app/graphql/mutations/base_mutation.rb", before: "\tend\nend") do
        "def model_errors!(model)\n# define me!\n"
      end
      generate_mutation('update')
      generate_mutation('create')
      generate_mutation('delete')
    end

    protected
    def generate_mutation(prefix)
      file_name = "#{prefix}_#{singular_name}"
      template("#{prefix}_mutation.rb", "app/graphql/mutations/#{class_path.join('/')}/#{file_name.underscore}.rb")
      insert_into_file("app/graphql/types/mutation_type.rb", after: "  class MutationType < Types::BaseObject\n") do
        "\t\tfield :#{file_name.camelcase(:lower)}, mutation: Mutations::#{prefixed_class_name(prefix)}\n"
      end
    end
  end
end