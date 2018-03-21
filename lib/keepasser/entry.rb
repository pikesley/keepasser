module Keepasser
  class Entry < Hash
    attr_accessor :data, :group

    def initialize data = nil
      @group = nil
      @data = data

      yield self if block_given?

      @data.map do |d|
        parts = d.split ': '
        if parts[1]
          self[parts[0].downcase.strip] = parts[1].strip
        end
      end

      self['comment'] = [self['comment']] if self['comment']
      @data.select { |f| f[0..5] == ' ' * 6 }.map { |c| self['comment'].push c.strip }
    end

    def id
      @id ||= "#{self['group']}::#{self['title']}"
    end

    def []= key, value
      if key == 'group'
        @group = value
      else
        super
      end
    end

    def [] key
      case key
      when 'group'
        @group
      when 'id'
        id
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
