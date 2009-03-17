require File.dirname(__FILE__) + '/spec_helper'
require File.dirname(__FILE__) + '/../lib/mimetype_fu'

# Ideally, the two solutions (`file` command versus simply looking at the extension)
# would return identical results, but thats not the case. `file` differentiates 
# between file sizes, and has a tendency to classify files into the 'application/octet-stream'
# mimetype, whereas, looking at the ext results in 'unknown/unknown' more often.

def create_file(filename, mode='w')
  @file = File.new(File.dirname(__FILE__) + "/fixtures/#{filename}", mode)
end

def close
  @file.close
  @file = @file.path
end

def open_file(filename, mode='r')
  @file = File.open(File.dirname(__FILE__) + "/fixtures/#{filename}", mode)
end

def write_file(filename, data, mode='wb')
  file = create_file(filename, mode)
  file.write(data)
  file.flush
end

def file_or_path(file)
  file.is_a?(File) ? file.path : file
end

def delete_file
  File.delete file_or_path(@file)
end

def it_should_have_an_extension_of(ext)
  it "should have an extension of #{ext}" do
    File.extname(file_or_path(@file)).should == ".#{ext}"
  end
end

def it_should_have_a_mime_type_of(mimetype)
  it "should have a mime type of #{mimetype}" do
    File.mime_type?(@file).should == mimetype
  end
end

describe "An open file" do
  
  describe "with a zero filelength" do
  
    before {create_file('file.empty')}

    it 'should have a length of zero' do
      File.size(@file).should == 0
    end

    it_should_have_a_mime_type_of("application/x-empty")
    
  end
  
  describe 'with a known extension' do

    before {write_file('file.png', "\211PNG\r\n\032\n", 'wb')}

    it 'should have a file size of greater than zero' do
      File.size(@file).should > 0
    end

    it_should_have_an_extension_of('png')
    it_should_have_a_mime_type_of("image/png")

  end
    
  describe 'with an unknown extension' do

    before {write_file('file.unknown', "\211Random\r\n\032\n", 'wb')}

    it 'should have a file size of greater than zero' do
      File.size(@file).should > 0
    end

    it_should_have_an_extension_of('unknown')
    it_should_have_a_mime_type_of("application/octet-stream")

  end
  
  describe 'with no extension' do

    before{write_file('file', "Random\r\n\032\n", 'wb')}

    it 'should have a file size of greater than zero' do
      File.size(@file).should > 0
    end

    it_should_have_a_mime_type_of("application/octet-stream")

  end
  
end

describe "A filepath (closed file)" do
  
  after(:each) do
    delete_file
  end
  
  describe "with a zero filelength" do
  
    before {create_file('file.empty'); close}

    it_should_have_a_mime_type_of("unknown/unknown")
    
  end
  
  describe 'with a known extension' do

    before {write_file('file.png', "\211PNG\r\n\032\n", 'wb'); close}

    it 'should have a file size of greater than zero' do
      File.size(@file).should > 0
    end

    it_should_have_an_extension_of('png')
    it_should_have_a_mime_type_of("image/png")

  end
    
  describe 'with an unknown extension' do

    before {write_file('file.unknown', "\211Random\r\n\032\n", 'wb'); close}

    it 'should have a file size of greater than zero' do
      File.size(@file).should > 0
    end

    it_should_have_an_extension_of('unknown')
    it_should_have_a_mime_type_of("unknown/unknown")

  end
  
  describe 'with no extension' do

    before{write_file('file', "Random\r\n\032\n", 'wb'); close}

    it 'should have a file size of greater than zero' do
      File.size(@file).should > 0
    end

    it_should_have_a_mime_type_of("unknown/unknown")

  end

end