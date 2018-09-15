require 'shrine'

if ENV['HANAMI_ENV'] == 'test'
  require 'shrine/storage/memory'

  Shrine.storages = {
    cache: Shrine::Storage::Memory.new,
    store: Shrine::Storage::Memory.new
  }
else
  require 'shrine/storage/s3'

  s3_options = {
    bucket: ENV.fetch('S3_BUCKET'),
    access_key_id: ENV.fetch('S3_ACCESS_KEY'),
    secret_access_key: ENV.fetch('SECRET_ACCESS_KEY'),
    region: ENV.fetch('AWS_REGION')
  }

  Shrine.storages = {
    cache: Shrine::Storage::S3.new(prefix: 'cache', **s3_options),
    store: Shrine::Storage::S3.new(**s3_options)
  }

end

Shrine.plugin :rack_file
Shrine.plugin :logging
Shrine.plugin :backgrounding
Shrine.plugin :determine_mime_type
