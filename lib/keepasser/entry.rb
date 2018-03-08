module Keepasser
  class Entry
    def initialize source
      data = source.split "\n"
      data.delete_if do |f|
        f == '' || f.chars.all? do |c|
          c == ' '
        end
      end

      @fields = {}
      data.map do |d|
        parts = d.split ':'
        if parts[1]
          @fields[parts[0].downcase] = parts[1].strip
        end
      end
    end

    def method_missing m, *args
      @fields[m.to_s]
    end
  end
end
