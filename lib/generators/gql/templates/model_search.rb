module Resolvers
  class <%= @resolver_prefix %><%= @model_name %>Search < Resolvers::BaseSearchResolver
    type [Types::<%= @model_name %>Type], null: false
    description "Lists <%= @model_name.downcase.pluralize %>"

    scope { <%= @model_name %>.all }
  
  <% @fields.each do |field| -%>
  option(:<%= field[:name] %>, type: <%= field[:gql_type] %>)   { |scope, value| scope.where <%= field[:name] %>: value }
  <% end %>
    def resolve
      []
    end

  end
end