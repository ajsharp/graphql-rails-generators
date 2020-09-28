module Mutations
  class <%= prefixed_class_name(mutation_prefix) %> < Mutations::BaseMutation
    field :<%= singular_name %>, Types::<%= @model_name %>Type, null: true

    argument :attributes, Types::Input::<%= @model_name %>Input, required: true
    argument :id, GraphQL::Types::ID, required: false

    def resolve(attributes:, id: nil)
      model = find_or_build_model(id)
      model.attributes = attributes.to_h

      if model.save
        {<%= singular_name %>: model}
      else
        {errors: model.errors.full_messages}
      end
    end

    def find_or_build_model(id)
      if id
        <%= @model_name %>.find(id)
      else
        <%= @model_name %>.new
      end
    end
  end
end