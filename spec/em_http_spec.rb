require 'spec_helper'

# try running requests async
describe 'em-http' do
  before :all do
    Keener.adapter = :em_http
  end

  context 'in an event machine loop' do
    it 'calls a passed block' do
      EventMachine.run do
        Keener.projects.get { |response|
          response.first.id.should eq(PROJECT_ID)
          EventMachine.stop
        }
      end
    end

    it 'returns a response' do
      EventMachine.run do
        Keener.projects.get.on_complete { |env|
          env[:body].first.id.should eq(PROJECT_ID)
          EventMachine.stop
        }
      end
    end
  end

  context 'in parallel' do
    subject :responses do
      responses = []

      Keener.in_parallel do |k|
        responses << k.count(PROJECT_ID, COLLECTION_NAME).get
        responses << k.count_unique(PROJECT_ID, COLLECTION_NAME, 'character').get
      end

      responses
    end

    it 'return the count' do
      responses.first.body.result.should eq(2757)
    end

    it 'returns the unique count' do
      responses.last.body.result.should eq(9)
    end
  end


  it 'runs outside an event machine loop' do
    Keener.projects.get.first.id.should eq(PROJECT_ID)
  end  
end

