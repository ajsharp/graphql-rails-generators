module Resolvers
  class BaseSearchResolver < GraphQL::Schema::Resolver
    require 'search_object'
    require 'search_object/plugin/graphql'
    include SearchObject.module(:graphql)
  end
end