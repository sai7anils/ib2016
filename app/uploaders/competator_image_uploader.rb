class CompetatorImageUploader < CarrierWave::Uploader::Base
  # include Cloudinary::CarrierWave
  include CarrierWave::MiniMagick
  version :thumb do
      process :resize_to_fill => [200, 200]
  end

  storage :file
  def store_dir
    "uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
  end

  def extension_whitelist
    %w(jpg jpeg gif png)
  end
end
