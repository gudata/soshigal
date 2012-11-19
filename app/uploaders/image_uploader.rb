# encoding: utf-8

class ImageUploader < CarrierWave::Uploader::Base
  include CarrierWave::MiniMagick
  include CarrierWave::MimeTypes
  include Sprockets::Helpers::RailsHelper
  include Sprockets::Helpers::IsolatedHelper

  EXTENSION_WHITE_LIST = %w(jpg jpeg gif png)

  process :set_content_type

  version :thumb do
    resize_to_fill(200, 200, 'North')
  end

  def store_dir
    File.join('uploads', 'images', model.album.slug)
  end

  def filename
    "#{md5}#{File.extname(super.to_s)}"
  end

  def default_url
    image_path('placeholder.png')
  end

  def extension_white_list
    EXTENSION_WHITE_LIST
  end

  def md5
    @md5 ||= (model.md5 || Digest::MD5.hexdigest(model.image.read))
  end

  def cached_master
    @cached_master ||= CarrierWave::SanitizedFile.new(
                         tempfile: StringIO.new(file.read),
                         filename: File.basename(path),
                         content_type: file.content_type
                       )
  end
end
