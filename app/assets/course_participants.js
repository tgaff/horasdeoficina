// Place all the behaviors and hooks related to the matching controller here.
//All this logic will automatically be available in application.js.

$(document).ready(function() {

  // page is now ready, initialize the calendar...
  if ($('#calendar').length > 0) {
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


function calendarSelect(start, end) {
  //var title = prompt('busy');
  var title = 'BUSY';
  var eventData;
  if (title) {
    eventData = {
      title: title,
      start: start,
      end: end,
      //rendering: 'background'
    };
    $('#calendar').fullCalendar('renderEvent', eventData, true); // stick? = true
  };
  $('#calendar').fullCalendar('unselect');

  console.log(start.format('dddd HH:mm'), title, end);
 // sendCalendarSelection(title, start, end);
};

function calendarSubmit() {
  console.log('submit called');
  var clientEvents = $('#calendar').fullCalendar( 'clientEvents' );
  $('input[name=wtbs]').val(encodeURIComponent(JSONifyClientEvents(clientEvents)));
  console.log(clientEvents);
  //$('#calendar-submit').submit();


}
function JSONifyClientEvents(clientEvents) {
  var strippedEvents = clientEvents.map(function(item) {
     return {
      title: item.title,
      start: item.start.format(),
      end: item.end.format()
    }
  });
  return JSON.stringify(strippedEvents);
}
/*
function sendCalendarSelection(title, start, end) {
  $.ajax({
    type: 'POST',
    url: '/weeklytimeblocks/create',
    data: {
      title: title,
      format: 'momentjs',
      start: start,
      end: end
    },
    success: function() {
      console.log("finished" + start);
    }
  });
}
*/
