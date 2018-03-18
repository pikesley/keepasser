module Keepasser
  describe MissingEntriesSpotter do
    context 'find extra entries' do
      left = Parser.new 'spec/fixtures/missing-entries/left.txt'
      right = Parser.new 'spec/fixtures/missing-entries/right.txt'
      mes = MissingEntriesSpotter.new left, right

      it 'finds the extra entries' do
        expect(mes.extras).to eq (
          {
            'Bluth Company' => [
              {
                'title' => 'Middleman',
                'username' => 'larry.middleman',
                'password' => 'bazbarfoo',
                'comment' => [
                  'this is a comment',
                  'also this is a comment',
                  'and this'
                ],
                'group' => 'Bluth Company',
                'id' => 'Bluth Company::Middleman'
              }
            ]
          }
        )
      end
    end
  end
end
