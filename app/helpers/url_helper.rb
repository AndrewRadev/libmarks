module UrlHelper
  def current_path
    current_uri.path
  end

  def current_url
    current_uri.to_s
  end

  def current_uri
    @current_uri ||= URI.parse(request.original_url)
  end

  def current_base_url?(url)
    URI.parse(url).path == current_path
  end
end
