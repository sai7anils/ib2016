class IdeaUploader < CarrierWave::Uploader::Base
  # include Cloudinary::CarrierWave

  storage :file
  # storage :fog
  def store_dir
    "uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
  end

end
