module Keepasser
  class Parser < Array
    attr_reader :path

    def initialize path
      @path = path
      lines = File.readlines @path

      first = true
      @bucket = []
      lines.each do |line|
        if line.is_group?
          @group = line.group
        else
          if line.is_title?
            if first
              @bucket = [line]
              first = false
            else
              if @bucket.any?
                push_entry
                @bucket = [line]
              end
            end
          else
            @bucket.push line
          end
        end
      end
      push_entry
    end

    def push_entry
      self.push(Entry.new do |e|
        e.data = @bucket
        e.group = @group
      end)
    end
  end
end

class String
  def is_group?
    self[0..8] == '*** Group'
  end

  def is_title?
    self[0..7] == '  Title:'
  end

  def group
    self.strip[11..-5]
  end
end
