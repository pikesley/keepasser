module Keepasser
  class Entry < Hash
    attr_accessor :group
    attr_reader :fields

    def initialize data
      data.map do |d|
        parts = d.split ': '
        if parts[1]
          self[parts[0].downcase.strip] = parts[1].strip
        end
      end

      self['comment'] = [self['comment']] if self['comment']
      data.select { |f| f[0..5] == '      ' }.map { |c| self['comment'].push c.strip }
    end

    def []= key, value
      if key == 'group'
        super
        self['id'] = "#{self['group']}::#{self['title']}"
      else
        super
      end
    end
  end
end
