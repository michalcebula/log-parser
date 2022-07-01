require_relative '../error/file_not_found'
require 'find'

module Service
  class FileLoader
    def load_by_name(file_name, path, not_found_error: Error::FileNotFound.new)
      file = find(file_name, path)
      raise not_found_error unless file
      File.open(file)
    end

    private

    def find(file_name, path)
      Find.find(path) do |file|
        return file if File.basename(file) == file_name
      end
    end
  end
end
