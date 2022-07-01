require '../parser'
require '../lib/service/entries_counter'
require '../lib/service/file_loader'
require '../lib/service/sorter'

RSpec.describe Parser do
  let(:file_loader) { instance_double(Service::FileLoader, load_by_name: test_file) }
  let(:test_file) { File.open('./support/test_file.log') }
  let(:counted_logs) { [{ '/first' => 3 }, { '/second' => 2 }, { '/third' => 1 }] }
  let(:counted_unique_logs) { [{ '/first' => 2 }, { '/second' => 1 }, { '/third' => 1 }] }

  let(:entries_counter) do
    instance_double(Service::EntriesCounter, count: counted_logs, count_unique: counted_unique_logs)
  end
  let(:parser) { described_class.new(file_loader: file_loader, entries_counter: entries_counter) }

  describe '#call' do
    it 'outputs formatted report' do
      expect { parser.call('test_file.log') }.to output(
        %r{Route: \/first; Entries number: \d\WRoute: \/second; Entries number: \d\WRoute: \/third; Entries number: \d}
      ).to_stdout
      expect(file_loader).to have_received(:load_by_name).with('test_file.log', any_args)
      expect(entries_counter).to have_received(:count).with(test_file)
    end
  end
end
