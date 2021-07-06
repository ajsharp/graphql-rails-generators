require_relative 'gql_generator_base'
module Gql
  class InputGenerator < Rails::Generators::Base
    include GqlGeneratorBase
    source_root File.expand_path('../templates', __FILE__)

    argument :model_name, type: :string

    class_option :name, type: :string
    class_option :include_columns, type: :array, default: []
    class_option :superclass, type: :string, default: 'Types::BaseInputObject'
    class_option :namespace, type: :string, default: 'Types::Input'

    def generate_input_type
      name = options['name'].nil? ? "#{model_name}Input" : options['name']
      superclass = options['superclass']

      ignore = ['id', 'created_at', 'updated_at']
      fields = map_model_types(model_name)
      fields.reject! { |field| ignore.include?(field[:name]) }
      if options['include_columns'].any?
        fields.reject! { |field| !options['include_columns'].include?(field[:name]) }
      end

      code = class_with_arguments(options['namespace'], name, superclass, fields)
      file_name = File.join(root_directory(options['namespace']), "#{name.underscore}.rb")

      create_file file_name, code
    end
  end
end
