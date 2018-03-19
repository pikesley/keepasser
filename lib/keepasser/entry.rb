module Keepasser
  class Entry < Hash
    attr_reader :group

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
        @group = value
        @id = "#{self['group']}::#{self['title']}"
      else
        super
      end
    end

    def [] key
      case key
      when 'group'
        @group
      when 'id'
        @id
      else
        super
      end
    end

    def display indent = 1
      s = ''
      self.each_pair do |k, v|
        if k == 'comment'
          s += "%s%s:\n" % ['  ' * indent, k]
          v.map do |comment|
            s += "%s%s%s\n" % ['  ' * indent, '  ', comment]
          end
        else
          s += "%s%s: %s\n" % ['  ' * indent, k, v]
        end
      end
      s
    end
  end
end
