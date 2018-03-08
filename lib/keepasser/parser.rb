module Keepasser
  class Parser < Array
    def initialize path
      lines = File.readlines path

      bucket= []
      lines.each do |line|
        if line[0..8] == '*** Group'
          @group = line[11..-6]
        else
          unless line == "\n"
            bucket.push line
          else
            if bucket.any?
              self.push Entry.new bucket
              self[-1].group = @group
              bucket = []
            end
          end
        end
      end
      self.push Entry.new bucket
      self[-1].group = @group
    end
  end
end
