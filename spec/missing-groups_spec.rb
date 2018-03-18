module Keepasser
  describe Comparator do
    context 'different data' do
      left = 'spec/fixtures/missing-groups/left.txt'
      right = 'spec/fixtures/missing-groups/right.txt'
      comparator = Comparator.new left, right

      it 'finds the rogue group' do
        expect(comparator.errors).to eq ({
          'Rogue groups' => {
            'Bluth Company' => [
              {
                'title' => 'Attorney',
                'username' => 'bob.loblaw',
                'url' => 'http://bobloblawlowblog.com',
                'password' => 'bobloblawlowblog',
                'group' => 'Bluth Company'
              },
              {
                'title' => 'Middleman',
                'username' => 'larry.middleman',
                'password' => 'bazbarfoo',
                'comment' => [
                  'this is a comment',
                  'also this is a comment',
                  'and this'
                ],
                'group' => 'Bluth Company'
              }
            ]
          }
        })
      end
    end
  end
end
