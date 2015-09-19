
$(document).ready(function() {

  // page is now ready, initialize the calendar...
  if ($('#calendar.calendar-course').length > 0) {
    $('#calendar').fullCalendar({
      defaultDate: moment("2015-08-03T12:24:05"),
      defaultView: 'agendaWeek',

      selectable: true,

      editable: true,

      header: { // destroy all headers
          center: '',
          left: '',
          right: ''
      },

      select: calendarSelect,

      events: WTBS // constant defined on page (may be blank)

    })
  }
});


