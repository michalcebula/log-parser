require '../../lib/service/file_loader'
require 'tempfile'

RSpec.describe Service::FileLoader do
  let(:file_loader) { described_class.new }

  describe '#load_by_name' do
    context 'when file does exist' do
      it 'returns file' do
        test_file = Tempfile.new('test_file', __dir__)
        file_name = File.basename(test_file)
        expect(file_loader.load_by_name(file_name, __dir__)).to be_a File
      end
    end

    context 'when file does not exist' do
      it 'raises FileNotFound error' do
        expect { file_loader.load_by_name('invalid_file_name', __dir__) }.to raise_error(Error::FileNotFound)
      end
    end

    context 'when argument is nil' do
      it 'raises FileNotFound error' do
        expect { file_loader.load_by_name(nil, __dir__) }.to raise_error(Error::FileNotFound)
      end
    end
  end
end
