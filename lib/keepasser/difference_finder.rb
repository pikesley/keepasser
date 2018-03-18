module Keepasser
  class DifferenceFinder
    attr_reader :diffs

    def initialize left, right
      @diffs = {}

      left.each do |entry|
        selection = right.select { |e| e['id'] == entry['id'] }[0]
        if selection
          unless selection == entry
            @diffs[entry['group']] = {} unless @diffs[entry['group']]
            entry.keys.each do |key|
              unless entry[key] == selection[key]
                @diffs[entry['group']][entry['title']] = {}
                @diffs[entry['group']][entry['title']][key] = [
                  entry[key], selection[key]
                ]
              end
            end
          end
        end
      end
    end
  end
end
