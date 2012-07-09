require File.expand_path(File.dirname(__FILE__) + '/spec_helper')

describe Thumbnailer::Maker do
    describe "Types of files" do
      it "accepts odt files" do
        maker = Thumbnailer::Maker.new(File.expand_path(File.dirname(__FILE__) + "/resources/file.odt"),
                                       "application/vnd.oasis.opendocument.text")
        maker.should_receive(:odt_thumbnail)
        maker.thumbnail
      end

      it "accepts pdf files" do
        maker = Thumbnailer::Maker.new(File.expand_path(File.dirname(__FILE__) + "/resources/file.pdf"),
                                       "application/pdf")
        maker.should_receive(:pdf_thumbnail)
        maker.thumbnail
      end
   end

   it "returns a saved thumbnail with png extension" do
    thumb_path = Thumbnailer::Maker.new(File.expand_path(File.dirname(__FILE__) + "/resources/file.odt"),
                                       "application/vnd.oasis.opendocument.text").thumbnail
    thumb_path =~ /.png/
  end

   it "returns a png thumbnail from a pdf" do
     thumb_path = Thumbnailer::Maker.new(File.expand_path(File.dirname(__FILE__) + "/resources/file.pdf"),
                                       "application/pdf").thumbnail

     #TODO - Make it work..
     #FileUtils.compare_file(thumb_path,
     #          File.expand_path(File.dirname(__FILE__) + "/resources/desired_pdf.png")).should be_true
   end

   it "returns a png thumbnail from a odt" do
     thumb_path = Thumbnailer::Maker.new(File.expand_path(File.dirname(__FILE__) + "/resources/file.odt"),
                                       "application/vnd.oasis.opendocument.text").thumbnail

     FileUtils.compare_file(thumb_path,
               File.expand_path(File.dirname(__FILE__) + "/resources/desired_odt.png")).should be_true
   end

   it 'with option string = true returns the base64 thumbnail string' do
    thumb_string = Thumbnailer::Maker.new(File.expand_path(File.dirname(__FILE__) + "/resources/file.odt"),
                "application/vnd.oasis.opendocument.text", string: true).thumbnail

    #compare the resulting image
    desired_thumb = File.open(File.expand_path(File.dirname(__FILE__) + "/resources/desired_odt.png"))
    thumb_string.should == Base64.encode64(desired_thumb.read)
  end
 end