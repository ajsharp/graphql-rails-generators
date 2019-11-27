module Types
  class <%= @model_name %>Type < Types::BaseObject
  <% @fields.each do |field| -%>
  field :<%= field[:name] %>, <%= field[:gql_type] %>, null: true
  <% end %>
  end
end