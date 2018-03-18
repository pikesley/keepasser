module Keepasser
  class Comparator
    attr_reader :errors

    def initialize left, right
      @left = Parser.new left
      @right = Parser.new right

      @errors = {}

      rogue_groups
      missing_entries
      different_data
    end

    def different_data
      unless @right == []
        @left.each_with_index do |entry, i|
          diffs = Keepasser.different_fields entry, @right[i]
          unless diffs == {}
            @errors['Different data'] = Keepasser.hash_tree
            @errors['Different data'][entry['group']][entry['title']] = diffs
          end
        end
        # @left.each_pair do |group, entries|
        #   entries.each_pair do |title, data|
        #     if data != @right[group][title]
        #       @errors['Different data'] = {}
        #       @errors['Different data'][group] = {}
        #       @errors['Different data'][group][title] = {}
        #       data.each_pair do |key, value|
        #         other_value = @right[group][title][key]
        #         if value != @right[group][title][key]
        #           @errors['Different data'][group][title][key] = [value, other_value]
        #         end
        #       end
        #     end
        #   end
        # end
      end
    end

    def missing_entries
      missing = @right - @left
      if missing
        @errors['Missing entries'] = {}
        Keepasser.extract_groups(missing).map do |g|
          @errors['Missing entries'][g] = []
        end
        missing.map do |m|
          @errors['Missing entries'][m['group']].push m
        end
      end
    end

    def rogue_groups
      rogue_groups = Keepasser.extract_groups(@right) - Keepasser.extract_groups(@left)
      if rogue_groups.length > 0
        @errors['Rogue groups'] = {}
        rogue_groups.each do |group|
          @errors['Rogue groups'][group] = Keepasser.entries_for_group @right, group
          @right = @right - @errors['Rogue groups']["Bluth Company"]
        end
      end
    end

    def to_s
      @errors.to_yaml.gsub ' !ruby/hash:Keepasser::Entry', ''
    end
  end
end
