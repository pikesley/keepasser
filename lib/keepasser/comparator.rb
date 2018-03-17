module Keepasser
  class Comparator
    attr_reader :errors

    def initialize left, right
      left = Parser.new left
      right = Parser.new right
require "pry" ; binding.pry
      @errors = {}

      rogue_groups = right.keys - left.keys
      if rogue_groups.length > 0
        @errors['Rogue groups'] = {}
        rogue_groups.map { |r| right[r] }.each do |g|
          g.keys.map do |k|
            e = g[k].fields
            begin
              @errors['Rogue groups'][g[k].group][k] = e
            rescue NoMethodError
              @errors['Rogue groups'][g[k].group] = {}
              @errors['Rogue groups'][g[k].group][k] = e
            end
          end
        end
        rogue_groups.map { |r| right.delete r }
      end

      left.keys.each do |group|
        missing = []

        begin
          left_diff = left[group].keys - right[group].keys
        rescue NoMethodError => e
          left_diff = []
        end
        left_diff.map { |entry| left[group].delete entry }

        begin
          right_diff = right[group].keys - left[group].keys
        rescue NoMethodError
          right_diff = []
        end
        missing += right_diff.map { |e| { e => right[group][e].fields } }
        right_diff.map { |entry| right[group].delete entry }

        if missing.any?
          begin
            @errors['Missing entries'][group] = missing.clone
          rescue NoMethodError
            @errors['Missing entries'] = {}
            @errors['Missing entries'][group] = missing.clone
          end
        end
      end

      unless right == {}
        left.each_pair do |group, entries|
          entries.each_pair do |title, data|
            if data.fields != right[group][title].fields
              @errors['Different data'] = {}
              @errors['Different data'][group] = {}
              @errors['Different data'][group][title] = {}
              data.fields.each_pair do |key, value|
                other_value = right[group][title].fields[key]
                if value != right[group][title].fields[key]
                  @errors['Different data'][group][title][key] = [value, other_value]
                end
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
