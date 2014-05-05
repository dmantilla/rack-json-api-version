require 'rubygems'
require 'rack/json/api/version'

describe Rack::Json::Api::Version do
  let(:app)   { Object.new }
  let(:klass) { Rack::Json::Api::Version }

  describe '.initialize' do
    it 'creates a new instance' do
      expect { klass.new(app, vendor: 'abc' ) }.not_to raise_error
    end

    context 'failures' do
      it 'complains when the vendor is missing' do
        expect { klass.new(app) }.to raise_error
      end
    end
  end

  describe '#extract_version' do
    let(:version) { klass.new(app, vendor: 'abc') }

    context 'valid versions' do
      it 'is version 1' do
        env = { 'HTTP_ACCEPT' => 'application/vnd.abc.v1+json'}
        expect(version.extract_version(env)).to eq('1')
      end

      it 'is version 1.1' do
        env = { 'HTTP_ACCEPT' => 'application/vnd.abc.v1.1+json'}
        expect(version.extract_version(env)).to eq('1.1')
      end
    end

    context 'version not found' do
      it 'returns nil' do
        env = { 'HTTP_ACCEPT' => 'application/json'}
        expect(version.extract_version(env)).to eq(nil)
      end

      it 'returns nil' do
        env = { 'HTTP_ACCEPT' => 'something'}
        expect(version.extract_version(env)).to eq(nil)
      end
    end
  end

  describe '#update' do
    let(:version) { klass.new(app, vendor: 'abc') }

    it 'does nothing' do
      env = {}
      version.update(env)
      expect(env).to eq({'api.version' => nil})
    end

    it 'sets the header and saves the original' do
      env = {'HTTP_ACCEPT' => 'application/vnd.abc.v1+json'}
      version.update(env)
      expect(env).to eq({
        'api.version'           => '1',
        'HTTP_ACCEPT'           => 'application/json',
        'ORIGINAL_HTTP_ACCEPT'  => 'application/vnd.abc.v1+json'
      })
    end
  end
end
