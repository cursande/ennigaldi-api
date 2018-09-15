class ImageType < GraphQL::Schema::Object
  description 'An Image'
  field :id, ID, null: false
  field :uri, String, null: false
end
