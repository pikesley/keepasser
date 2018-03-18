module Keepasser
  class MissingEntriesSpotter
    attr_reader :left, :right, :extras

    def initialize left, right
      @left = left
      @right = right

      spurions = []
      @right.each do |entry|
        unless @left.map { |e| e['id'] }.include? entry['id']
          spurions.push entry
        end
      end

      @extras = Keepasser.groupify spurions
      @right -= spurions
    end
  end
end
