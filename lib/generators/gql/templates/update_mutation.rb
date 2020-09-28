module Mutations
  class <%= prefixed_class_name('Update') %> < Mutations::BaseMutation
    field :<%= singular_name %>, Types::<%= name %>Type, null: true

    argument :id, GraphQL::Types::ID, required: true
    argument :attributes, Types::Input::<%= name %>Input, required: true
    
    def resolve(attributes:, id:)
      model = <%= class_name %>.find(id)

      if model.update_attributes(attributes.to_h)
        {<%= singular_name %>: model}
      else
        model_errors!(model)
      end
    end
  end
end