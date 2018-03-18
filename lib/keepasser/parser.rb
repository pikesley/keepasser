module Keepasser
  class Parser < Array
    attr_reader :path

    def initialize path
      @path = path
      lines = File.readlines @path

      bucket= []
      lines.each do |line|
        if line[0..8] == '*** Group'
          @group = line[11..-6]
        else
          unless line == "\n"
            bucket.push line
          else
            if bucket.any?
              e = Entry.new bucket
              e['group'] = @group

              self.push e.clone

              bucket = []
            end
          end
        end
      end
      e = Entry.new bucket
      e['group'] = @group

      self.push e.clone
    end
  end
end
