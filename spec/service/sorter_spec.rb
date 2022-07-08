require 'service/sorter'

RSpec.describe Service::Sorter do
  let(:sorter) { described_class.new }
  let(:sample_file) { File.open('spec/support/test_file.log') }
  let(:sorted_logs) do
    [
      { route: '/first', address: '111.111.111.111' },
      { route: '/second', address: '222.222.222.222' },
      { route: '/third', address: '333.333.333.333' },
      { route: '/first', address: '111.111.111.111' },
      { route: '/first', address: '444.444.444.444' },
      { route: '/second', address: '222.222.222.222' }
    ]
  end
  let(:sorted_unique_logs) do
    [
      { route: '/first', address: '111.111.111.111' },
      { route: '/second', address: '222.222.222.222' },
      { route: '/third', address: '333.333.333.333' },
      { route: '/first', address: '444.444.444.444' }
    ]
  end

  describe '#sort_by_entries' do
    it 'returns ordered number of entries per route' do
      result = sorter.sort_by_entries(sample_file)

      expect(result).to eq sorted_logs
    end
  end

  describe '#sort_by_unique_entries' do
    it 'returns ordered number of entries per route' do
      result = sorter.sort_by_unique_entries(sample_file)

      expect(result).to eq sorted_unique_logs
    end
  end
end
