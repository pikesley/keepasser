module Keepasser
  describe Comparator do
    context 'multiple differences' do
      left = 'spec/fixtures/multiple-diffs/left.txt'
      right = 'spec/fixtures/multiple-diffs/right.txt'
      comparator = Comparator.new left, right

      it 'identifies the differences' do
        expect(comparator.errors).to eq ({
          'Missing entries' => {
            'Bluth Company' => [
              {
                'title' => 'Adoptee',
                'username' => 'annyong',
                'password' => 'annyong',
                'group' => 'Bluth Company',
                'id' => 'Bluth Company::Adoptee'
              }
            ]
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
  - title: Adoptee
    username: annyong
    password: annyong
    group: Bluth Company
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
