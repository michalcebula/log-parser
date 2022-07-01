require_relative 'lib/service/file_loader'
require_relative 'lib/service/entries_counter'

class Parser
  def initialize(file_loader: Service::FileLoader.new, entries_counter: Service::EntriesCounter.new)
    @file_loader = file_loader
    @entries_counter = entries_counter
  end

  def call(file_name)
    file = @file_loader.load_by_name(file_name, __dir__)
    print_output(file)
  end

  private

  def print_output(file)
    puts 'Entries:'
    format_entries_list(@entries_counter.count(file))
    puts "\nUnique entries:"
    format_entries_list(@entries_counter.count_unique(file))
  end

  def format_entries_list(entries_list)
    entries_list.each do |log_data|
      puts "Route: #{log_data.keys[0]}; Entries number: #{log_data.values[0]}"
    end
  end
end
