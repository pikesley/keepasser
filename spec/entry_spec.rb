module Keepasser
  describe Entry do
    context 'make a simple entry' do
      source = [
        'Title:    Secret Stuff',
        'Username: michael.bluth',
        'Url:      https://bluth.com',
        'Password: terrible_mistake',
        'Comment:'
      ]
      entry = Entry.new source

      it 'has fields' do
        expect(entry['title']).to eq 'Secret Stuff'
        expect(entry['username']).to eq 'michael.bluth'
      end

      it 'rejects blank fields' do
        expect(entry['comment']).to be nil
      end
    end

    context 'entry with multi-line comment' do
      source = [
'Title:    Commented stuff',
'Username: gob.bluth',
'Url:',
'Password: loose_seal',
'Comment:   comments',
'           more comments',
'           yet more comments'
      ]
      entry = Entry.new source

      it 'has comments' do
        expect(entry['password']).to eq 'loose_seal'
        expect(entry['comment']).to eq [
          'comments',
          'more comments',
          'yet more comments'
        ]
      end
    end

    context 'assign a group' do
      source = [
'Title:    Secret Stuff',
'Username: michael.bluth'
      ]
      entry = Entry.new source
      entry['group'] = 'Blue Man Group'

      it 'takes a group' do
        expect(entry['group']).to eq 'Blue Man Group'
      end

      specify 'the group is ephemeral' do
        expect(entry).to eq (
          {
            'title' => 'Secret Stuff',
            'username' => 'michael.bluth'
          }
        )
      end
    end

    context 'assign an ID' do
      source = [
'Title:    Michael Bluth',
'Username: michael.bluth'
      ]
      entry = Entry.new source
      entry['group'] = 'Bluth Company'

      it 'has an ID' do
        expect(entry['id']).to eq 'Bluth Company::Michael Bluth'
      end

      specify 'the ID is ephemeral' do
        expect(entry).to eq (
          {
            'title' => 'Michael Bluth',
            'username' => 'michael.bluth'
          }
        )
      end
    end

    context 'presentation' do
      source = [
'Title:    Michael Bluth',
'Username: michael.bluth'
      ]
      entry = Entry.new source
      entry['group'] = 'Bluth Company'

      it 'prints nicely' do
        expect(entry.display).to eq (
"""  title: Michael Bluth
  username: michael.bluth
""")
      end

      it 'takes different indentation' do
        expect(entry.display 3).to eq (
"""      title: Michael Bluth
      username: michael.bluth
""")
      end
    end

    context 'presentation with comments' do
      source = [
'Title:    George Bluth',
'Username: george.bluth',
'Password: notouching',
'Comment:   comments',
'           more comments',
'           yet more comments'
      ]
      entry = Entry.new source

      it 'prints nicely with comments' do
        expect(entry.display).to eq (
"""  title: George Bluth
  username: george.bluth
  password: notouching
  comment:
    comments
    more comments
    yet more comments
"""
        )
      end
    end
  end
end
