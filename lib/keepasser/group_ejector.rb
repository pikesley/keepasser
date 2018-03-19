module Keepasser
  class GroupEjector
    attr_reader :left, :right, :rogues

    def initialize left, right
      @left = left
      @right = right

      right_groups = @right.map { |e| e['group'] }.uniq
      left_groups = @left.map { |e| e['group'] }.uniq

      difference = right_groups - left_groups

      if difference.length > 0
        spurions = []

        difference.map do |d|
          s = @right.select { |g| g['group'] == d }
          spurions.push s
        end
        spurions.flatten!
        @rogues = Keepasser.groupify spurions
        @right -= spurions
      end
    end

    def to_s
      s = ''
      @rogues.each_pair do |group, entries|
        s += "  %s:\n" % group
        entries.map do |e|
          s += "%s\n" % e.display(2)
        end
      end
      s
    end
  end
end
