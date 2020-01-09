module Mutations
  class <%= prefixed_class_name('Create') %> < Mutations::BaseMutation
    field :<%= singular_name %>, Types::<%= name %>Type, null: true

    argument :attributes, Types::Input::<%= name %>Input, required: true

    def resolve(attributes:)
      model = <%= name %>.new(attributes.to_h)

      if model.save
        {<%= singular_name %>: model}
      else
        model_errors!(model)
      end
    end
  end
end