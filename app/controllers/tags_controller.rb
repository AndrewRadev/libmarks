class TagsController < ApplicationController
  def prefetch
    tags = ActsAsTaggableOn::Tag.all
    render_json(tags)
  end

  def search
    tags = ActsAsTaggableOn::Tag.where('name LIKE ?', "#{params[:q]}%")
    render_json(tags)
  end

  private

  def render_json(tags)
    render json: tags.map { |t| {id: t.id, name: t.name} }
  end
end
