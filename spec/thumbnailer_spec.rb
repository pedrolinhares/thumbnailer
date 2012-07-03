require File.expand_path(File.dirname(__FILE__) + '/spec_helper')

describe "Thumbnailer" do
  it "receives a file path and mimetype" do
    Thumbnailer.make_thumbnail(File.expand_path(File.dirname(__FILE__) + "/resources/file.odt"),
                "application/vnd.oasis.opendocument.text")

    Thumbnailer.instance_variable_get(:@file_path).should == File.expand_path(File.dirname(__FILE__) + "/resources/file.odt")
    Thumbnailer.instance_variable_get(:@mimetype).should == "application/vnd.oasis.opendocument.text"
  end

  it "returns a saved thumbnail with png extension" do
    thumb_path = Thumbnailer.make_thumbnail(File.expand_path(File.dirname(__FILE__) + "/resources/file.odt"),
                "application/vnd.oasis.opendocument.text")
    thumb_path =~ /.png/
  end

  describe "Types of files" do
    it "accepts odt files" do
      Thumbnailer.should_receive(:odt_thumbnail)
      Thumbnailer.make_thumbnail(File.expand_path(File.dirname(__FILE__) + "/resources/file.odt"),
                "application/vnd.oasis.opendocument.text")
    end
  end
end
