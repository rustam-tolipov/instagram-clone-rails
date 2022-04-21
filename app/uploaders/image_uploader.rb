class ImageUploader < Shrine
  Attacher.validate do
    validate_max_size 12.megabyte, message: 'is too large (max is 12 MB)'
    validate_mime_type_inclusion ['image/jpg', 'image/jpeg', 'image/png', 'image/gif']
  end
end
