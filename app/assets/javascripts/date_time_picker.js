$(function() {
  function initFlatpickr() {
    $(".flatpickr").flatpickr({
      enableTime: true,
      altInput: true,
      altFormat: "j F Y, l, \\Saat: H:i",
      allowInput: true,
      minDate: "today",
      time_24hr: true,
      minuteIncrement: 15,
      locale: {
        weekdays: {
          shorthand: ["Paz", "Pzt", "Sal", "Çar", "Per", "Cum", "Cmt"],
          longhand: ["Pazar", "Pazartesi", "Salı", "Çarşamba", "Perşembe", "Cuma", "Cumartesi"]
        },
        months: {
          shorthand: ["Oca", "Şub", "Mar", "Nis", "May", "Haz", "Tem", "Ağu", "Eyl", "Eki", "Kas", "Ara"],
          longhand: ["Ocak", "Şubat", "Mart", "Nisan", "Mayıs", "Haziran", "Temmuz", "Ağustos", "Eylül", "Ekim", "Kasım", "Aralık"]
        },
        firstDayOfWeek: 1,
        ordinal: function ordinal() {
          return ".";
        },
        rangeSeparator: " - ",
        weekAbbreviation: "Hf",
        scrollTitle: "Artırmak için kaydırın",
        toggleTitle: "Aç/Kapa",
        amPM: ["ÖÖ", "ÖS"]
      }
    })
  }

  initFlatpickr()

  $(document).on("turbolinks:load", function() {
    initFlatpickr()
  })

})