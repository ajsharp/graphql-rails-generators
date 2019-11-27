require_relative 'gql_generator_base'
module Gql
  class ModelTypeGenerator < Rails::Generators::Base
    include GqlGeneratorBase
    source_root File.expand_path('../templates', __FILE__)
    argument :model_name, type: :string

    def type
      file_name = "#{model_name.underscore}_type"
      @fields = map_model_types(model_name)
      template('model_type.rb', "app/graphql/types/#{file_name}.rb")
    end
  end
end