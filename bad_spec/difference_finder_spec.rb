module Keepasser
  describe DifferenceFinder do
    context 'find differing data' do
      left = Parser.new 'spec/fixtures/differing-passwords/left.txt'
      right = Parser.new 'spec/fixtures/differing-passwords/right.txt'
      df = DifferenceFinder.new left, right

      it 'finds the differing passwords' do
        expect(df.diffs).to eq (
          {
            'Bluth Company' => {
              'Middleman' => {
                'password' => [
                  'foobarbaz',
                  'bazbarfoo'
                ]
              }
            }
          }
        )
      end

      it 'presents itself nicely' do
        expect(df.to_s).to eq (
"""  Bluth Company:
    Middleman:
      password:
      - foobarbaz
      - bazbarfoo
""")
      end
    end
  end
end
