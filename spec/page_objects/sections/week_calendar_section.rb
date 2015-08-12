class WeekCalendarSection < SitePrism::Section

  module CalendarEvents
    def event_location(number)
      ".fc-time-grid .fc-content-skeleton tr td:nth-child(#{number}) a.fc-event"
    end
  end
  include CalendarEvents
  extend CalendarEvents


  elements :events, 'a.fc-event'

  elements :sunday_events,    event_location(2), visible: false
  elements :monday_events,    event_location(3), visible: false
  elements :tuesday_events,   event_location(4), visible: false
  elements :wednesday_events, event_location(5), visible: false
  elements :thursday_events,  event_location(6), visible: false
  elements :friday_events,    event_location(7), visible: false
  elements :saturday_events,  event_location(8), visible: false

  element :sunday,     '.fc-time-grid .fc-sun'
  element :monday,     '.fc-time-grid .fc-mon'
  element :tuesday,    '.fc-time-grid .fc-tue'
  element :wednesday,  '.fc-time-grid .fc-wed'
  element :thursday,   '.fc-time-grid .fc-thu'
  element :friday,     '.fc-time-grid .fc-fri'
  element :saturday,   '.fc-time-grid .fc-sat'

  elements :time_rows, '.fc-slats tbody tr' # pass text: '6pm' to get more specific
  def has_event?(on:, at:)
    event_matcher = build_event_css(on, at)
    root_element.has_css? event_matcher
  end
  def event(on:, at:)
    event_matcher = build_event_css(on, at)
    root_element.find event_matcher
  end
  # finds events on the calendar for a specific day and specific start, end time
  # times are like '10:30 AM - 2:30 PM' or '3:00'
  def get_event_at_date_time(day, start_time, end_time='', *args)
    # data-full
    #.fc-time
    event_matcher = build_event_css(day, start_time, end_time, *args)
    find(event_matcher)
  end


  # dragging...
  # at this point we can only drag to wednesday times because individual time rows aren't broken into days
  # or we can drag to 12 on any day because aren't broken into times...
  def find_time_row(time) # format '5pm'
    @root_element.find('.fc-slats tbody tr', text: time)
  end
  alias :time_row :find_time_row
  private

  def build_event_css(day, start_time, end_time='', *args)
    [start_time, end_time].each(&:upcase!)
    day = day_number(day) if day.class == String
    time_query = event_location(day_number(day))
    if end_time.blank?
      time_query = time_query + " [data-full^='#{start_time}']"
    else
      time_query = time_query + " [data-full='#{start_time} - #{end_time}']"
    end
    time_query
  end
  # returns the column number for day, can handle days like
  #  'sunday', 'sun', 2
  def day_number(word)
    day_map = { sun: 2,
                mon: 3,
                tue: 4,
                wed: 5,
                thu: 6,
                fri: 7,
                sat: 8 }
    word.to_s if word.is_a? Symbol
    word = word.slice(0..2) if word.is_a? String
    word.is_a?(String) ? day_map[word.to_sym] : word
  end
end
