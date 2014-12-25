# TODO:
#
# - Extract input into separate file
# - Figure out API, also to attach logic into new inputs
# - Figure out input persistence, maybe with a hidden input?
#

$.fn.tagInput = ->
  $(this).each ->
    new App.Widgets.TagInput($(this))

window.App = {}
window.App.Widgets = {}

class App.Widgets.TagInput
  constructor: (@$input) ->
    @$input.wrap("""<span class="tag-input-container"/>""")
    @$container = $input.parent()
    @tags = []

    @$input.addClass('tag-input-input')

    @updateTagsFromInput()

    @$input.on 'keyup', (e) =>
      val = @$input.val()

      if val == '' and e.which == 8 # backspace
        e.preventDefault()
        @removeLastTag()
      else if val != '' and e.which == 188 # comma
        e.preventDefault()
        @updateTagsFromInput()

    @$container.on 'click', '.tag-input-remove', (e) =>
      $tag = $(e.currentTarget).parent('.tag-input-tag')
      $tag.remove()
      @updateTagsFromTagList()

  updateTagsFromTagList: ->
    @tags = []
    @$container.find('.tag-input-tag').each (e, i) =>
      @tags.push($(e).text())

  updateTagsFromInput: ->
    newTags = []
    for tag in @$input.val().split(/,\s*/)
      if $.trim(tag) != ''
        newTags.push(tag)

    @$input.val('')

    for tag in newTags
      @tags.push(tag)
      @$input.before """
        <span class="tag-input-tag">
          #{tag}
          <span class="tag-input-remove">&times;</span>
        </span>
      """

  removeLastTag: ->
    @$container.find('.tag-input-tag').last().remove()
