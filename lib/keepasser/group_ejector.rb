module Keepasser
  class GroupEjector
    attr_reader :left, :right, :rogues

    def initialize left, right
      @left = left
      @right = right
      @rogues = {}

      spurions = @right - @left
      spurions.map { |s| s['group'] }.uniq.map { |g| @rogues[g] = [] }
      spurions.map { |s| @rogues[s['group']].push s }

      @right -= spurions
    end
  end
end
