require 'spec_helper'

# try running requests async
describe 'em-http' do
  before :all do
    Keener.adapter = :em_http
  end

  context 'within an event machine loop' do
    it 'calls a passed block' do
      EventMachine.run do
        Keener.projects.get { |response|
          response.first.id.should eq('50e8d5f43843316b28000001')
          EventMachine.stop
        }
      end
    end

    it 'returns a response unfinished respons object' do
      EventMachine.run do
        Keener.projects.get.on_complete { |env|
          env[:body].first.id.should eq('50e8d5f43843316b28000001')
          EventMachine.stop
        }
      end
    end
  end

  it 'runs outside an event machine loop' do
    Keener.projects.get.first.id.should eq('50e8d5f43843316b28000001')
  end  
end

