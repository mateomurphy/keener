require 'spec_helper'

describe Keener::Api do
  before :all do
    Keener.reset_connection    
    Keener.adapter = nil
  end

  describe '.count' do
    context 'without options', :vcr => { :cassette_name => 'count/no_options' } do
      subject :count do
        Keener.count(PROJECT_ID, COLLECTION_NAME).get
      end

      its (:result) { should eq(2757) }
    end

    context 'grouped by character', :vcr => { :cassette_name => 'count/grouped' } do
      subject :count do
        Keener.count(PROJECT_ID, COLLECTION_NAME, :group_by => 'character').get.result.first
      end

      its (:character) { should eq('Troi') }
      its (:result) { should eq(101) }
    end    
  end

  describe '.count_unique', :vcr => { :cassette_name => 'count_unique' } do
    subject :count_unique do
      Keener.count_unique(PROJECT_ID, COLLECTION_NAME, 'character').get
    end

    its (:result) { should eq(9) }
  end

  describe '.events', :vcr => { :cassette_name => 'events' } do
    subject :events do
      Keener.events(PROJECT_ID).get
    end

    its (:count) { should eq(1)}

    it 'returns votes' do
      events.first.name.should eq('votes')
    end
  end

  describe '.project', :vcr => { :cassette_name => 'project' } do
    subject :project do
      Keener.project(PROJECT_ID).get
    end

    it 'returns the right project id' do
      project.id.should eq(PROJECT_ID)
    end
  end

  describe '.projects', :vcr => { :cassette_name => 'projects' } do
    subject :projects do
      Keener.projects.get
    end

    its (:count) { should eq(1)}

    it 'returns the right project id' do
      projects.first.id.should eq(PROJECT_ID)
    end
  end
end