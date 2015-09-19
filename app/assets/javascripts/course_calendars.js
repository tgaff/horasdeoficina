
$(document).ready(function() {

  // mark all events as background
  for (var i=0; i < WTBS.length; i++) {
    WTBS[i].rendering = 'background';
    //WTBS[i].backgroundColor = '#036';
    WTBS[i].backgroundColor = 'rgba(0,0,255,0.3)';

  };
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

function resetCalendar() {
  getCalendar('removeEvents'); // all events
  getCalendar('renderEvents', WTBS);
}

function getCalendar() {
  if ($('#calendar.calendar-course').length >0) {
    return $('#calendar').fullCalendar(arguments);
  }
}


