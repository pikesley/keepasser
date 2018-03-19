require 'yaml'
require 'thor'

require 'keepasser/version'
require 'keepasser/entry'
require 'keepasser/parser'
require 'keepasser/comparator'
require 'keepasser/group_ejector'
require 'keepasser/missing_entries_spotter'
require 'keepasser/difference_finder'

def Keepasser.extract_groups data
  data.map { |e| e['group'] }.uniq.sort
end

def Keepasser.entries_for_group data, group
  data.select { |e| e['group'] == group }
end

def Keepasser.different_fields left, right
  diffs = {}
  left.each_pair do |k, v|
    unless left[k] == right[k]
      diffs[k] = [left[k], right[k]]
    end
  end
  diffs
end

def Keepasser.groupify list
  data = {}
  list.map { |s| s['group'] }.uniq.map { |g| data[g] = [] }
  list.map { |s| data[s['group']].push s }
  data
end
