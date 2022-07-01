module Service
  class Sorter
    def sort_by_entries(file)
      logs_list =
        File
          .readlines(file)
          .map do |line|
            log = line.split(' ')
            { route: log.first, address: log.last }
          end
    end

    def sort_by_unique_entries(file)
      sort_by_entries(file).uniq
    end
  end
end
