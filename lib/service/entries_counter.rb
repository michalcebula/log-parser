require_relative 'sorter'

module Service
  class EntriesCounter
    def initialize(sorter: Service::Sorter.new)
      @sorter = sorter
    end

    def count(file)
      logs_list = @sorter.sort_by_entries(file)
      counter(logs_list)
    end

    def count_unique(file)
      logs_list = @sorter.sort_by_unique_entries(file)
      counter(logs_list)
    end

    private

    def counter(logs_list)
      entries_list = logs_list.each_with_object(Hash.new(0)) { |log, hash| hash[log[:route]] += 1 }
      sorted_entries_list = entries_list.sort_by { |route, entries| entries }.reverse
      sorted_entries_list.map { |log| { log.first => log.last } }
    end
  end
end
