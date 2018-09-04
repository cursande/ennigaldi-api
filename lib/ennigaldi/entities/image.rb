require_relative '../../../apps/web/uploaders/image_uploader'

class Image < Hanami::Entity
  include ImageUploader[:image_data]

end
