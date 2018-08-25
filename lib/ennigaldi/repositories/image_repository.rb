class ImageRepository < Hanami::Repository
  associations do
    belongs_to :article
  end
end
