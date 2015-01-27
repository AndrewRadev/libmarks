$ ->
  # Taken from vimrcfu, with some modifications:
  # https://github.com/florianbeer/vimrcfu/blob/b003f027c619d4d1c99117b695a1099f6987463b/public/js/tagging.js
  #
  tags = new Bloodhound
    datumTokenizer: Bloodhound.tokenizers.obj.whitespace("name")
    queryTokenizer: Bloodhound.tokenizers.whitespace
    dupDetector: (remoteMatch, localMatch) ->
      remoteMatch.id is localMatch.id
    prefetch:
      url: "/tags/prefetch"
      ttl: 300000
    remote:
      url: "/tags/search?q=%QUERY"

  tags.initialize()

  $('.js-tag-input').tagsinput
    tagClass: "label label-default"
    trimValue: true
    typeaheadjs:
      name:       "tags"
      displayKey: "name"
      valueKey:   "name"
      source:     tags.ttAdapter()

  $origEl = $('.js-tag-input')
  $tagsEl = $('.bootstrap-tagsinput')

  tagsinput = $origEl.tagsinput("input")
  tagsinput
    .on "focus", ->
      $tagsEl.addClass("focus")
    .on "blur", ->
      $tagsEl.removeClass("focus")
      $origEl.tagsinput("add", $(".tt-input").val())
      tagsinput.val("")
