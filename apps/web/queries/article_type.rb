require_relative './image_type.rb'

class ArticleType < GraphQL::Schema::Object
  description "An Article"
  field :id, ID, null: false
  field :title, String, null: false
  field :content, String, null: false
  field :content_summary, String, null: false
  field :types, String, null: false
  field :authors, String, null: false
  field :images, [ImageType], null: false
end
