require 'keepasser'

module Keepasser
  class CLI < ::Thor
    desc 'version', 'Print keepasser version'
    def version
      puts "keepasser version #{VERSION}"
    end
    map %w(-v --version) => :version

    desc 'compare <a_file> <another_file>', 'Compare two KeepassX exports'
    def compare left, right
      comparator = Comparator.new left, right
      puts comparator
    end
  end
end
