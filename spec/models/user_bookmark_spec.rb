require 'rails_helper'

describe UserBookmark do
  describe "github link" do
    def api_url(project_name)
      "https://api.github.com/repos/AndrewRadev/#{project_name}"
    end

    def public_url(project_name)
      "http://github.com/AndrewRadev/#{project_name}"
    end

    describe ".create_from_list" do
      let(:user) { create :user }

      it "can create a list of valid bookmarks" do
        valid_bookmarks, invalid_bookmarks = UserBookmark.create_from_list(user, [
          'http://google.com',
          'http://foo.bar',
        ])

        valid_bookmarks.count.should eq 2
        invalid_bookmarks.should be_empty
      end

      it "finds invalid bookmarks" do
        valid_bookmarks, invalid_bookmarks = UserBookmark.create_from_list(user, [
          'http://google.com',
          'foo bar baz',
        ])

        valid_bookmarks.count.should eq 1
        invalid_bookmarks.count.should eq 1
      end
    end

    describe "#fetch_url_info" do
      let(:url) { 'http://github.com/AndrewRadev/splitjoin.vim' }
      let(:bookmark) { build :user_bookmark, url: url }

      around :each do |example|
        Timecop.freeze { example.run }
      end

      it "fetches the right info from github" do
        stub_request(:get, api_url('splitjoin.vim')).to_return({
          body: {
            'description' => 'A vim plugin',
            'language'    => 'VimL',
          }.to_json
        })

        bookmark.fetch_url_info

        bookmark.info_fetched_at.should eq Time.zone.now
        bookmark.source.should eq 'github'
        bookmark.info.should eq({
          'description' => 'A vim plugin',
          'language'    => 'VimL',
        })
      end

      it "handles errors" do
        stub_request(:get, api_url('splitjoin.vim')).to_return({
          status: 500
        })

        bookmark.fetch_url_info

        bookmark.info_fetched_at.should eq Time.zone.now
        bookmark.source.should eq 'github_error'
        bookmark.info.should have_key("error")
      end
    end

    describe ".refresh_all_info" do
      it "refreshes the info for multiple bookmarks" do
        stub_request(:get, api_url('splitjoin.vim')).to_return({
          body: { 'description' => 'Updated splitjoin info' }.to_json
        })
        stub_request(:get, api_url('switch.vim')).to_return({
          body: { 'description' => 'Updated switch info' }.to_json
        })

        first_bookmark = create(:user_bookmark, {
          url:  public_url('splitjoin.vim'),
          info: {description: 'Splitjoin info'},
        })
        second_bookmark = create(:user_bookmark, {
          url: 'http://github.com/AndrewRadev/switch.vim',
        })

        UserBookmark.refresh_all_info

        first_bookmark.reload.info['description'].should eq 'Updated splitjoin info'
        second_bookmark.reload.info['description'].should eq 'Updated switch info'
      end
    end

    describe "#connect_project" do
      it "finds an existing project if there is one" do
        project = create :project, name: 'switch.vim'
        bookmark = create :user_bookmark, url: 'http://github.com/AndrewRadev/switch.vim'
        bookmark.connect_project

        bookmark.project.should eq project
      end

      it "creates a new project from the given link" do
        bookmark = create :user_bookmark, url: 'http://github.com/AndrewRadev/switch.vim'
        bookmark.connect_project

        bookmark.project.name.should eq 'switch.vim'
        bookmark.project.main_url.should eq 'http://github.com/AndrewRadev/switch.vim'
      end

      it "sets the given user as the owner of a new project" do
        user = create :user
        bookmark = create :user_bookmark, url: 'http://github.com/AndrewRadev/switch.vim'
        bookmark.connect_project(user)

        bookmark.project.user.should eq user
      end
    end
  end
end
