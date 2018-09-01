class ImageRepository < Hanami::Repository
  include ImageUploader::Attachment.new(:image)

  associations do
    belongs_to :article
  end
end
