module Mutations
  class <%= prefixed_class_name('Delete') %> < Mutations::BaseMutation
    field :<%= singular_name %>, Types::<%= name %>Type, null: true

    argument :id, GraphQL::Types::ID, required: true

    def resolve(id:)
      model = <%= class_name %>.find(id)

      model.destroy
      {<%= singular_name %>: model}
    end
  end
end