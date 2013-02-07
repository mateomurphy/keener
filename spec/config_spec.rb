require 'spec_helper'

describe Keener::Config do
  it 'can get and set a config' do
    Keener.api_key.should eq(API_KEY)
  end
end