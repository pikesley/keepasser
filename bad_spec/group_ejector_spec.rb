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
              'password' => 'bluemyself'
            },
            {
              'title' => 'Blue Man',
              'username' => 'blue.man',
              'url' => 'https://www.blueman.com/',
              'password' => 'password'
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
            'password' => 'bobloblawlowblog'
          },
          {
            'title' => 'Middleman',
            'username' => 'larry.middleman',
            'password' => 'bazbarfoo',
            'comment' => [
              'this is a comment',
              'also this is a comment',
              'and this'
            ]
          }
        ]
      end

      it 'presents itself nicely' do
        expect(ge.to_s).to eq (
'''  Blue Man Group:
    title: Idiot
    username: tobias.funke
    url: https://www.blueman.com/
    password: bluemyself

    title: Blue Man
    username: blue.man
    url: https://www.blueman.com/
    password: password

''')
      end
    end
  end

  context 'ignore when groups are matching' do
    left = Parser.new 'spec/fixtures/missing-entries/left.txt'
    right = Parser.new 'spec/fixtures/missing-entries/right.txt'
    ge = GroupEjector.new left, right

    it 'does nothing' do
      expect(ge.rogues).to eq nil
    end
  end
end
