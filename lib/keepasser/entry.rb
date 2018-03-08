module Keepasser
  class Entry
    attr_accessor :group
    attr_reader :fields

    def initialize data
      @fields = {}
      data.map do |d|
        parts = d.split ':'
        if parts[1]
          @fields[parts[0].downcase.strip] = parts[1].strip
        end
      end

      @fields['comment'] = [@fields['comment']] if @fields['comment']
      data.select { |f| f[0..5] == '      ' }.map { |c| @fields['comment'].push c.strip }
    end

    def [] key
      @fields[key]
    end

    def method_missing m, *args
      @fields[m.to_s]
    end

    def == other
      @fields == other.fields
    end
  end
end
