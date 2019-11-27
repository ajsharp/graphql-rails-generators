require_relative 'gql_generator_base'
module Gql
  class InputGenerator < Rails::Generators::Base
    include GqlGeneratorBase
    source_root File.expand_path('../templates', __FILE__)
    argument :model_name, type: :string
  
    def generate_input_type
      file_name = model_name

      ignore = ['id', 'created_at', 'updated_at']
      @fields = map_model_types(model_name).reject { |field| ignore.include?(field[:name]) }

      template('input_type.rb', "app/graphql/types/input/#{file_name.underscore}_input.rb")
    end
  end
end