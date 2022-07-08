require 'service/entries_counter'
require 'service/sorter'

RSpec.describe Service::EntriesCounter do
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
  let(:sorter) do
    instance_double(Service::Sorter, sort_by_entries: sorted_logs, sort_by_unique_entries: sorted_unique_logs)
  end
  let(:counter) { described_class.new(sorter: sorter) }
  let(:sample_file) { File.open('spec/support/test_file.log') }

  describe '#count' do
    it 'returns ordered number of entries per route' do
      result = counter.count(sample_file)

      expect(sorter).to have_received(:sort_by_entries).with(sample_file)

      entries_number_list = result.map { |log| log.values[0] }
      sample_log = result.first

      expect(result).to be_an Array
      expect(sample_log).to eq({ '/first' => 3 })
      expect(entries_number_list.max).to eq entries_number_list.first
      expect(entries_number_list.min).to eq entries_number_list.last
    end
  end

  describe '#count_unique' do
    it 'returns ordered number of entries per route' do
      result = counter.count_unique(sample_file)

      expect(sorter).to have_received(:sort_by_unique_entries).with(sample_file)

      entries_number_list = result.map { |log| log.values[0] }
      sample_log = result.first

      expect(result).to be_an Array
      expect(result.count).to eq 3
      expect(sample_log).to eq({ '/first' => 2 })
      expect(entries_number_list.max).to eq entries_number_list.first
      expect(entries_number_list.min).to eq entries_number_list.last
    end
  end
end
