require "cloudinary"
require "shrine/storage/cloudinary"

Cloudinary.config(
  cloud_name: ENV["CLOUD_NAME"],
  api_key:    ENV["CLOUD_API_KEY"],
  api_secret: ENV["CLOUD_API_SECRET"]
)

Shrine.storages = {
  cache: Shrine::Storage::Cloudinary.new(prefix: "test_insta/cache"), # for direct uploads
  store: Shrine::Storage::Cloudinary.new(prefix: "test_insta"), 
}

Shrine.plugin :activerecord
Shrine.plugin :cached_attachment_data # for retaining the cached file across form redisplays
Shrine.plugin :restore_cached_data # re-extract metadata when attaching a cached file
Shrine.plugin :validation_helpers
Shrine.plugin :validation