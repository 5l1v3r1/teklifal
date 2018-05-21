$(function() {
  $(document).on("turbolinks:load", function() {
    if (!$('.attachment-input').length) return

    $("input[type=file]").change(function() {
      var fileInputs = $(this).closest('.form-group').find('input[type=file]')


      var isAnEmpty = fileInputs.toArray().some(function(input) {
        return input.files[0] === undefined
      })

      console.log(isAnEmpty)
      if (!!isAnEmpty) return


      var clonedField = $(this).closest('.attachment').clone(true)
      clonedField.find('input[type=file]').val('')
      $(this).closest('.attachment').parent().append(clonedField)
    })
  })

})