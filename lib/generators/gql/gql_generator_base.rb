require 'rails/generators/base'

module Gql
  module GqlGeneratorBase
    protected

    # Generate a namedspaced class name with the mutation prefix
    def prefixed_class_name(prefix)
      (class_path + ["#{prefix}_#{file_name}"]).map!(&:camelize).join("::")
    end

    def type_map
      {
        integer: 'Int',
        string: 'String',
        boolean: 'Boolean',
        decimal: 'Float',
        datetime: 'GraphQL::Types::ISO8601DateTime',
        date: 'GraphQL::Types::ISO8601Date',
        hstore: 'GraphQL::Types::JSON',
        text: 'String',
        json: 'GraphQL::Types::JSON'
      }
    end

    def map_model_types(model_name)
      klass = model_name.constantize
      associations = klass.reflect_on_all_associations(:belongs_to)
      bt_columns = associations.map(&:foreign_key)

      klass.columns
        .reject { |col| bt_columns.include?(col.name) }
        .reject { |col| type_map[col.type].nil? }
        .map do |col|
          {
            name: col.name,
            null: col.null,
            gql_type: klass.primary_key == col.name ? 'GraphQL::Types::ID' : type_map[col.type]
          }
        end
    end

    def root_directory(namespace)
      "app/graphql/#{namespace.underscore}"
    end

    def wrap_in_namespace(namespace)
      namespace = namespace.split('::')
      namespace.shift if namespace[0].empty?

      code = namespace.each_with_index.map { |name, i| "  " * i + "module #{name}" }.join("\n")
      code << "\n" << yield(namespace.size) << "\n"
      code << (namespace.size - 1).downto(0).map { |i| "  " * i  + "end" }.join("\n")
      code
    end

    def class_with_fields(namespace, name, superclass, fields)
      wrap_in_namespace(namespace) do |indent|
        klass = []
        klass << sprintf("%sclass %s < %s", "  " * indent, name, superclass)

        fields.each do |field|
          klass << sprintf("%sfield :%s, %s, null: %s", "  " * (indent + 1), field[:name], field[:gql_type], field[:null])
        end

        klass << sprintf("%send", "  " * indent)
        klass.join("\n")
      end
    end
  end
end
