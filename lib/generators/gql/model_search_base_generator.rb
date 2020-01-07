module Gql
  class ModelSearchBaseGenerator < Rails::Generators::Base          
    source_root File.expand_path('../templates', __FILE__)    
    def generate_model_search_base
      gem 'search_object_graphql'    
      template('model_search_base.rb', "app/graphql/resolvers/base_search_resolver.rb")
    end
  end
end