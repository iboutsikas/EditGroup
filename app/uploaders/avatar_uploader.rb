# encoding: utf-8
class AvatarUploader < CarrierWave::Uploader::Base

  # Include RMagick or MiniMagick support:
  #include CarrierWave::RMagick
  include CarrierWave::MiniMagick

  # Choose what kind of storage to use for this uploader:
  storage :file
  # storage :fog

  # Override the directory where uploaded files will be stored.
  # This is a sensible default for uploaders that are meant to be mounted:
  def store_dir
    "uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
  end

  # Provide a default URL as a default if there hasn't been a file uploaded:
   def default_url
     # For Rails 3.1+ asset pipeline compatibility:
     # ActionController::Base.helpers.asset_path("fallback/" + [version_name, "default.png"].compact.join('_'))
    "fallback/default_avatar.png"
   end

  # Process files as they are uploaded:
  #process :resize_to_fill => [400, 400]
  #
  # def scale(width, height)
  #   :resize_to_fit => [400, 400]
  # end

  # Create different versions of your uploaded files:

  version :thumb do
    process :crop
    process resize_to_fill: [70, 70]
  end

  version :cropped do
    process :crop
    process resize_to_fill: [400,400]
  end

  def crop
    return if model.crop_x.blank?
    resize_to_limit(600,600)
    manipulate! do |img|
      img.crop "#{model.crop_w.to_i}x#{model.crop_h.to_i}+#{model.crop_x.to_i}+#{model.crop_y.to_i}!"
      img
    end
  end

  # Add a white list of extensions which are allowed to be uploaded.
  # For images you might use something like this:
  def extension_white_list
    %w(jpg jpeg gif png)
  end

  # Override the filename of the uploaded files:
  # Avoid using model.id or version_name here, see uploader/store.rb for details.
  # def filename
  #   "something.jpg" if original_filename
  # end

end
