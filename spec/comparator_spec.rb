module Keepasser
  describe Comparator do
    context 'different data' do
      left = 'spec/fixtures/differing-passwords/left.txt'
      right = 'spec/fixtures/differing-passwords/right.txt'
      comparator = Comparator.new left, right

      it 'finds the differing passwords' do
        expect(comparator.errors).to eq ({
          'Different data' => {
            'Bluth Company' => {
              'Middleman' => {
                'password' => [
                  'foobarbaz',
                  'bazbarfoo'
                ]
              }
            }
          }
        })
      end
    end

    context 'missing entries' do
      left = 'spec/fixtures/missing-entries/left.txt'
      right = 'spec/fixtures/missing-entries/right.txt'
      comparator = Comparator.new left, right

      it 'identifies the missing entries' do
        expect(comparator.errors).to eq ({
          'Missing entries' => {
            'Bluth Company' => ['Middleman']
          }
        })
      end
    end

    context 'multiple differences' do
      left = 'spec/fixtures/multiple-diffs/left.txt'
      right = 'spec/fixtures/multiple-diffs/right.txt'
      comparator = Comparator.new left, right

      it 'identifies the differences' do
        expect(comparator.errors).to eq ({
          'Missing entries' => {
            'Bluth Company' => ['Adoptee']
          },
          'Different data' => {
            'Sitwell Enterprises' => {
              'Employee' => {
                'password' => [
                  'foobar',
                  'barfoo'
                ]
              }
            }
          }
        })
      end

      it 'presents itself nicely' do
        expect(comparator.to_s).to eq """---
Missing entries:
  Bluth Company:
  - Adoptee
Different data:
  Sitwell Enterprises:
    Employee:
      password:
      - foobar
      - barfoo
"""
      end
    end
  end
end