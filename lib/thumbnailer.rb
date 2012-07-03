require 'zip/zip'

class Thumbnailer
  def self.make_thumbnail(file_path, mimetype)
    @file_path = file_path
    @mimetype = mimetype

    odt_thumbnail if @mimetype =~ /opendocument.text/
  end

  private

  def self.odt_thumbnail
    odt = Zip::ZipFile.open(@file_path)
    thumb = odt.read("Thumbnails/thumbnail.png")
    thumb_file = File.new("thumbnail-#{Time.now.to_i}.png", 'w')
    thumb_file.write(thumb)
    thumb_file.close
    thumb_file.path
  end
end