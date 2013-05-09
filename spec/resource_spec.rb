require 'spec_helper'

describe Keener::Resource do
  subject :resource do
    Keener::Resource.new
  end
  
  describe '#prepare_options' do
    it "should convert a filter to a json string" do
      input = {:filters=>[{:property_name=>"context.account_id", :operator=>"eq", :property_value=>4}], :group_by=>"context.site_id", :event_collection=>"download"}
      output = {:filters=>'[{"property_name":"context.account_id","operator":"eq","property_value":4}]', :group_by => "context.site_id", :event_collection=>"download"}

      resource.prepare_options(input).should eq(output)
    end

  end
end