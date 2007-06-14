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
   File.mime_type?(@file).should == "image/jpeg"
  end
  
end

describe 'A valid file path' do
  
  before(:each) do
    @file_path = "#{Dir.pwd} + /picture.png"
  end
  
  it 'should have a mime type' do
    File.mime_type?(@file_path).should == "image/png"
  end
  
end

describe "An unknown extension" do
    
    before(:each) do
      @file_path = 'file.unknown'
    end
    
    it 'should have an unknown mime type' do
      File.mime_type?(@file_path).should == "unknown/unknown"
    end
end