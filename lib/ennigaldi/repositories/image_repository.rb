require_relative '../../../apps/web/uploaders/image_uploader'

class ImageRepository < Hanami::Repository
  prepend ImageUploader.repository(:image_data)

  associations do
    belongs_to :article
  end
end
