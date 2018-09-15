require_relative './image_type.rb'

class ArticleType < GraphQL::Schema::Object
  description 'An Article'
  field :id, ID, null: false
  field :title, String, null: true
  field :content, String, null: true
  field :content_summary, String, null: true
  field :types, String, null: true
  field :authors, String, null: true
  field :images, [ImageType], null: true
end
