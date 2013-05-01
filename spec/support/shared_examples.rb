shared_examples 'a sync adapter' do
  it 'makes a blocking request' do
    Keener.projects.get.first.id.should eq(PROJECT_ID)
  end 
end

shared_examples 'an async adapter' do
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

  it 'returns a body containing a ResourceNotFoundError' do
    EventMachine.run do
      Keener.project('xxx').get.on_complete { |env|
        env[:body].should be_a(Keener::Error::ResourceNotFoundError)
        EventMachine.stop
      }
    end
  end
end

shared_examples 'a parallel adapter' do
  subject :responses do
    responses = []

    Keener.in_parallel do |k|
      responses << k.count(PROJECT_ID, COLLECTION_NAME).get
      responses << k.count_unique(PROJECT_ID, COLLECTION_NAME, 'character').get
    end

    responses
  end

  it 'return the count' do
    responses.first.body.result.should be > 2757
  end

  it 'returns the unique count' do
    responses.last.body.result.should be > 9
  end
end