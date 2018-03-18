module Keepasser
  class MissingEntriesSpotter
    attr_reader :extras

    def initialize left, right
      @extras = {}

      spurions = []
      right.each do |entry|
        unless left.map { |e| e['id'] }.include? entry['id']
          spurions.push entry
        end
      end

      spurions.map { |s| s['group'] }.uniq.map { |g| @extras[g] = [] }
      spurions.map { |s| @extras[s['group']].push s }
    end
  end
end
