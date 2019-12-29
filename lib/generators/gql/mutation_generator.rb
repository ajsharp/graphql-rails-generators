require "rails/generators/named_base"

module Gql
  class MutationGenerator < Rails::Generators::NamedBase
    remove_argument :name # remove name base default arg

    argument :mutation_prefix, type: :string
    argument :model_name, type: :string
    source_root File.expand_path('../templates', __FILE__)

    # hack to keep NamedBase helpers working
    def name
      model_name
    end

    # Generate a namedspaced class name with the mutation prefix
    def prefixed_class_name
      (class_path + ["#{mutation_prefix}_#{file_name}"]).map!(&:camelize).join("::")
    end
  
    def mutation
      file_name = "#{mutation_prefix}_#{singular_name}"
      template('model_mutation.rb', "app/graphql/mutations/#{class_path.join('/')}/#{file_name.underscore}.rb")
    end
  end
  
end