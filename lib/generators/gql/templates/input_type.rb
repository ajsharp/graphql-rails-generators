module Types
  module Input
    class <%= @model_name %>Input < Types::BaseInputObject
  <% @fields.each do |field| -%>
    argument :<%= field[:name] %>, <%= field[:gql_type] %>, required: false
  <% end %>
    end
  end
end