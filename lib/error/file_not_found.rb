module Error
  class FileNotFound < StandardError
    def initialize(msg = 'File not found. Send a valid file name')
      super
    end
  end
end
