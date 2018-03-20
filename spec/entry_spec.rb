module Keepasser
  describe Entry do
    source = [
      'Title:    Github',
      'Username: pikesley',
      'Url:      https://github.com',
      'Password: githubpassword',
      'Comment:'
    ]

    comments = [
      'Comment:  comments',
      '          more comments',
      '          yet more comments'
    ]

    context 'make a simple entry' do
      entry = Entry.new source

      it 'has fields' do
        expect(entry['title']).to eq 'Github'
        expect(entry['username']).to eq 'pikesley'
      end

      it 'rejects blank fields' do
        expect(entry['comment']).to be nil
      end
    end

    context 'entry with multi-line comment' do
      entry = Entry.new source + comments

      it 'has comments' do
        expect(entry['comment']).to eq [
          'comments',
          'more comments',
          'yet more comments'
        ]
      end
    end

    context 'multi-line comment with blank lines' do
      comments_with_blank_line = [
        'Comment:  the next line is blank',
        '          ',
        '          intentionally'
      ]
      entry = Entry.new source + comments_with_blank_line

      it 'has comments' do
        expect(entry['password']).to eq 'githubpassword'
        expect(entry['comment']).to eq [
          'the next line is blank',
          '',
          'intentionally'
        ]
      end
    end

    context 'assign a group' do
      entry = Entry.new source
      entry['group'] = 'web'

      it 'takes a group' do
        expect(entry['group']).to eq 'web'
      end

      specify 'the group is ephemeral' do
        expect(entry).to eq (
          {
            'title' => 'Github',
            'username' => 'pikesley',
            'password' => 'githubpassword',
            'url' => 'https://github.com'
          }
        )
      end
    end

    context 'assign an ID' do
      entry = Entry.new source
      entry['group'] = 'web'

      it 'has an ID' do
        expect(entry['id']).to eq 'web::Github'
      end

      specify 'the ID is ephemeral' do
        expect(entry).to eq (
          {
            'title' => 'Github',
            'username' => 'pikesley',
            'password' => 'githubpassword',
            'url' => 'https://github.com'
          }
        )
      end
    end

    context 'presentation' do
      entry = Entry.new source
      entry['group'] = 'web'

      it 'prints nicely' do
        expect(entry.display).to eq (
"""  title: Github
  username: pikesley
  url: https://github.com
  password: githubpassword
""")
      end

      it 'takes different indentation' do
        expect(entry.display 3).to eq (
"""      title: Github
      username: pikesley
      url: https://github.com
      password: githubpassword
""")
      end
    end

    context 'presentation with comments' do
      entry = Entry.new source + comments

      it 'prints nicely with comments' do
        expect(entry.display).to eq (
"""  title: Github
  username: pikesley
  url: https://github.com
  password: githubpassword
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
