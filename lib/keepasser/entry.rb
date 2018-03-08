module Keepasser
  class Entry
    attr_accessor :group
    
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

      @fields['comment'] = [@fields['comment']] if @fields['comment']
      data.select { |f| f[0..5] == '      ' }.map { |c| @fields['comment'].push c.strip }
    end

    def method_missing m, *args
      @fields[m.to_s]
    end
  end
end
