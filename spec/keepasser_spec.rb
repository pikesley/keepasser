module Keepasser
  describe 'extract_groups' do
    it 'extracts groups' do
      data = Parser.new 'spec/fixtures/multiple-groups.txt'
      expect(Keepasser.extract_groups data).to eq [
        'Bluth Company',
        'Sitwell Enterprises'
      ]
    end
  end

  describe 'extract entries for group' do
    it 'extracts the entries with a group' do
      data = Parser.new 'spec/fixtures/multiple-groups.txt'
      expect(Keepasser.entries_for_group data, 'Bluth Company').to eq [
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
          'password' => 'foobarbaz',
          'comment' => [
            'this is a comment',
            'also this is a comment',
            'and this'
          ],
          'group' => 'Bluth Company'
        }
      ]
    end
  end

  describe 'differing fields' do
    it 'finds differing field' do
      left = {
        "title"=>"Middleman",
        "username"=>"larry.middleman",
        "password"=>"foobarbaz",
        "group"=>"Bluth Company"
      }

      right = {
        "title"=>"Middleman",
        "username"=>"larry.middleman",
        "password"=>"bazbarfoo",
        "group"=>"Bluth Company"
      }

      expect(Keepasser.different_fields left, right).to eq (
        {
          'password' => [
            'foobarbaz',
            'bazbarfoo'
          ]
        }
      )
    end
  end
end
