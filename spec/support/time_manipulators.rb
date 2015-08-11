def momentjs_time(day, time)
  DateTime.new(2015,8, day, time.split(':')[0].to_i, time.split(':')[1].to_i).strftime("%Y-%m-%dT%H:%M-00:00")
end

def uri_jsonify(input)
  URI.encode input.to_json
end
