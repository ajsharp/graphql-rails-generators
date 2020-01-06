require 'rails/generators/base'
# require 'active_support/extend'
module Gql
  module GqlGeneratorBase
    extend ActiveSupport::Concern

    included do
      protected
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
          .map { |col| {name: col.name, gql_type: type_map.fetch(col.type)} }
      end
    end
  end
end