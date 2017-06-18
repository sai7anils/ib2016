class UserUploader < CarrierWave::Uploader::Base
  # include Cloudinary::CarrierWave
  include CarrierWave::MiniMagick
  version :thumb do
  	process :resize_to_fill => [200, 200]
	end

  storage :file
  # storage :fog
  def store_dir
    "uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
  end

end
