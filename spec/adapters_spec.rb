require 'spec_helper'

describe 'adapters' do
  describe 'em-http' do
    before :all do
      Keener.reset_connection
      Keener.adapter = :em_http
    end

    it_behaves_like "a sync adapter"
    it_behaves_like "an async adapter"
    it_behaves_like "a parallel adapter"
  end

  describe 'em-synchrony' do
    before :all do
      Keener.reset_connection
      Keener.adapter = :em_synchrony
    end

    it_behaves_like "a sync adapter"
    it_behaves_like "a parallel adapter"
  end
end