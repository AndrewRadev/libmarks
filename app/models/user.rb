class User < ActiveRecord::Base
  has_many :authentications

  has_many :project_connections
  has_many :projects, through: :project_connections

  validates :email, presence: true, uniqueness: true

  def github_client
    @github_client ||=
      begin
        github_auth = authentications.find_by!(provider: 'github')
        GithubClients.user_client(github_auth.token)
      end
  end
end
