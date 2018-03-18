module Keepasser
  class GroupEjector
    attr_reader :left, :right, :rogues

    def initialize left, right
      @left = left
      @right = right

      if ((@left.map { |e| e['group'] }.uniq) - (@right.map { |e| e['group'] }.uniq)).length > 0
        spurions = @right - @left
        @rogues = Keepasser.groupify spurions
        @right -= spurions
      end
    end
  end
end
