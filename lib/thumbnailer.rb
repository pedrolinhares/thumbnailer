require 'zip/zip'
require 'quick_magick'
require 'base64'
require 'tempfile'

module Thumbnailer
  class << self
    def create(file_path, mimetype, params = {})
      Maker.new(file_path, mimetype, params).thumbnail
    end
  end

  class Maker
    def initialize(file_path, mimetype, params = {})
      params = {width: 181, height: 256, string: false}.merge params
      @file_path = file_path
      @mimetype = mimetype
      @width = params[:width]
      @height = params[:height]
      @return_string = params[:string]
    end

    def thumbnail
      return odt_thumbnail if @mimetype =~ /opendocument.text/
      return pdf_thumbnail if @mimetype =~ /pdf/
    end

    private

    def odt_thumbnail
      odt = Zip::ZipFile.open(@file_path)
      thumb = odt.read("Thumbnails/thumbnail.png")

      return Base64.encode64(thumb) if @return_string

      thumb_file = File.new("thumbnail#{Time.now.to_i}.png", 'w')
      thumb_file.write(thumb)
      thumb_file.close
      thumb_file.path
    end

    def pdf_thumbnail
      pdf = QuickMagick::Image.read(@file_path) { |image| image.density = 300 }
      pdf[0].resize "#{@width}x#{@height}"
      thumb_name = "thumbnail#{Time.now.to_i}.png"

      pdf[0].save thumb_name

      if @return_string
        string = Base64.encode64(File.open(thumb_name).read)
        File.delete thumb_name
        return string
      end

      thumb_name
    end
  end
end
