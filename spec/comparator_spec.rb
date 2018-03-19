module Keepasser
  describe Comparator do
    context 'multiple differences' do
      left = 'spec/fixtures/multiple-diffs/left.txt'
      right = 'spec/fixtures/multiple-diffs/right.txt'
      comparator = Comparator.new left, right

      it 'presents the data' do
        expect(comparator.to_s).to eq (
"""Rogue groups:
  Blue Man Group:
    title: Idiot
    username: tobias.funke
    url: https://www.blueman.com/
    password: bluemyself

Missing entries:
  Bluth Company:
    title: Adoptee
    username: annyong
    password: annyong

Different data:
  Sitwell Enterprises:
    Employee:
      password:
      - foobar
      - barfoo
""")
      end
    end
  end
end
