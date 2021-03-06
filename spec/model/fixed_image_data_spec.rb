require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

include Moo::Model

describe Moo::Model::FixedImageData do
  describe 'initialize' do

    it 'sets link_id to nil' do
      d = FixedImageData.new
      d.link_id.should == nil
    end

    it 'sets resource_uri to nil' do
      d = FixedImageData.new
      d.resource_uri.should == nil
    end
  end

  describe 'type' do
    it "returns 'fixedImageData'" do
      d = FixedImageData.new
      d.type.should == 'fixedImageData'
    end
  end

  describe 'resource_uri=' do
    it "sets the value of resource_uri" do
      d = FixedImageData.new
      d.resource_uri = 'http://example.com'
      d.resource_uri.should == 'http://example.com'
    end

    it "should complain if resource uri is not a string" do
      d = FixedImageData.new
      expect { d.resource_uri = 12 }.should raise_error ArgumentError
    end
  end

  describe 'to_json' do
    it 'represents FixedImageData object as json' do
      d = FixedImageData.new
      expected_json = {
        type: d.type,
        linkId: 'fixed_image_link_id',
        resourceUri: 'abc://123'
      }.to_json
      
      d.link_id = 'fixed_image_link_id'
      d.resource_uri = 'abc://123'

      d.to_json.should == expected_json
    end
  end

  describe 'from_json' do
    it 'sets fixed image data based on json' do
      d = FixedImageData.new
      json = {
        type: d.type,
        linkId: 'blah_bleeh_blooh',
        resourceUri: 'waah-weeh-wooh'
      }.to_json
      d.from_json json
      d.link_id.should == 'blah_bleeh_blooh'
      d.resource_uri.should == 'waah-weeh-wooh'
    end
  end
end
