$(document).on 'change', '.btn-file :file', ->
  file = $(this).get(0).files[0]
  $('.fn-file-name').val(file.name)
  fileReader = new FileReader()
  fileReader.onload = (event) =>
    $('.fn-image-preview').attr('src', event.target.result)
    $('.image-preview').show()
  fileReader.readAsDataURL(file)
