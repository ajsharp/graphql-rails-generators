require 'rails/generators/base'

module Gql
  module GqlGeneratorBase
    extend ActiveSupport::Concern

    included do
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
          hstore: 'GraphQL::Types::JSON'
        }
      end
  
      def map_model_types(model_name)
        klass = model_name.constantize
        associations = klass.reflect_on_all_associations(:belongs_to)
        bt_columns = associations.map(&:foreign_key)
  
        klass.columns
          .reject { |col| bt_columns.include?(col.name) }
          .map { |col| {name: col.name, gql_type: type_map.fetch(col.type)} }
      end
    end
  end
end