require File.dirname(__FILE__) + '/spec_helper'
require File.dirname(__FILE__) + '/../lib/mimetype_fu'

describe 'A file' do
  
  before(:each) do
    @file = File.open(File.dirname(__FILE__) + '/fixtures/file.jpg')
  end
  
  it 'should have and extension' do
    File.extname(@file.path).should == '.jpg'
  end
  
  it 'should have a mime type' do
    MimeTypeFu.new(@file).mime.should == "image/jpeg"
  end
  
end