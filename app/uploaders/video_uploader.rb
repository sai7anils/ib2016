class VideoUploader < CarrierWave::Uploader::Base
  storage :file

  def store_dir
    "#{Rails.env}/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
  end

  def extension_white_list
    %w(mp4 avi)
  end

end
