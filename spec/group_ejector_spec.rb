 module Keepasser
  describe GroupEjector do
    context 'eject rogue groups' do
      left = Parser.new 'spec/fixtures/missing-groups/left.txt'
      right = Parser.new 'spec/fixtures/missing-groups/right.txt'
      ge = GroupEjector.new left, right

      it 'spots the rogue group' do
        expect(ge.rogues).to eq ({
          'Blue Man Group' => [
            {
              'title' => 'Idiot',
              'username' => 'tobias.funke',
              'url' => 'https://www.blueman.com/',
              'password' => 'bluemyself',
              'group' => 'Blue Man Group'
            },
            {
              'title' => 'Blue Man',
              'username' => 'blue.man',
              'url' => 'https://www.blueman.com/',
              'password' => 'password',
              'group' => 'Blue Man Group'
            }
          ]
          })
      end

      it 'removes the rogue group' do
        expect(ge.right).to eq [
          {
            'title' => 'Attorney',
            'username' => 'bob.loblaw',
            'url' => 'http://bobloblawlowblog.com',
            'password' => 'bobloblawlowblog',
            'group' => 'Bluth Company'
          }
        ]
      end
    end
  end
end
