module ProjectHelper
  def language_icon_path(project, image_options = {})
    path = "language_icons/#{project.language.downcase}.png"
    asset = Rails.application.assets[path]

    if asset and File.exists?(asset.pathname)
      image_path(path)
    else
      image_path("language_icons/unknown.png")
    end
  end
end
