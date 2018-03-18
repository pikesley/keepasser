module Keepasser
  class Comparator
    attr_reader :errors

    def initialize left, right
      @left = Parser.new left
      @right = Parser.new right

      @errors = {}

      g = GroupEjector.new @left, @right
      if g.rogues
        @errors['Rogue groups'] = g.rogues
        @left = g.left
        @right = g.right
      end

      m = MissingEntriesSpotter.new @left, @right
      if m.extras
        @errors['Missing entries'] = m.extras
        @left = m.left
        @right = m.right
      end

      d = DifferenceFinder.new @left, @right
      if d.diffs
        @errors['Different data'] = d.diffs
      end
    end

    def to_s
      @errors.to_yaml
    end
  end
end
