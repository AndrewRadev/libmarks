EmberCli.configure do |c|
  c.app :frontend
end

EmberCli[:frontend].build

asset_symlink = Rails.root.join('app/assets/javascripts/ember-cli-frontend')
frontend_dir  = Rails.root.join('tmp/ember-cli/apps/frontend')

if not File.exists?(asset_symlink)
  FileUtils.ln_s(frontend_dir, asset_symlink)
end
