module Keepasser
  class Parser < Array
    attr_reader :path

    def initialize path
      @path = path
      lines = File.readlines @path

      first = true
      bucket = []
      lines.each do |line|
        if line[0..8] == '*** Group'
          @group = line[11..-6]
        else
          if line[0..7] == '  Title:'
            if first
              bucket = [line]
              first = false
            else
              if bucket.any?
                e = Entry.new bucket
                e['group'] = @group

                self.push e.clone

                bucket = [line]
              end
            end
          else
            bucket.push line
          end
        end
      end
      e = Entry.new bucket
      e['group'] = @group

      self.push e.clone
    end
  end
end
