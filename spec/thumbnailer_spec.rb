require File.expand_path(File.dirname(__FILE__) + '/spec_helper')

describe Thumbnailer do
  it "create should send thumbnail message to Maker" do
    Thumbnailer::Maker.any_instance.should_receive(:thumbnail)
    Thumbnailer.create(File.expand_path(File.dirname(__FILE__) + "/resources/file.odt"),
                "application/vnd.oasis.opendocument.text")
  end
end
