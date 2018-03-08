module Keepasser
  class Comparator
    attr_reader :errors

    def initialize left, right
      parsers = [Parser.new(left), Parser.new(right)]

      @errors = {}

      parsers[0].keys.each do |group|
        missing = []
        left = parsers[0][group].keys - parsers[1][group].keys
      #  missing += left
        left.map { |entry| parsers[0][group].delete entry }

        right = parsers[1][group].keys - parsers[0][group].keys
        missing += right
        right.map { |entry| parsers[1][group].delete entry }

        if missing.any?
          begin
            @errors['Missing entries'][group] = missing.clone
          rescue NoMethodError
            @errors['Missing entries'] = {}
            @errors['Missing entries'][group] = missing.clone
          end
        end
      end

      parsers[0].each_pair do |group, entries|
        entries.each_pair do |title, data|
          if data.fields != parsers[1][group][title].fields
            @errors['Different data'] = {}
            @errors['Different data'][group] = {}
            @errors['Different data'][group][title] = {}
            data.fields.each_pair do |key, value|
              other_value = parsers[1][group][title].fields[key]
              if value != parsers[1][group][title].fields[key]
                @errors['Different data'][group][title][key] = [value, other_value]
              end
            end
          end
        end
      end
    end

    def to_s
      @errors.to_yaml
    end
  end
end
