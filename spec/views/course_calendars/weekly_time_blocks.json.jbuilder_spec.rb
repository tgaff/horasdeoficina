require 'spec_helper'

describe 'course_calendars/weekly_time_blocks' do
  let(:wtbs) { FactoryGirl.build_stubbed_list(:weekly_time_block, 3) }
  let(:parsed) { JSON.parse rendered }
  before do
    wtbs.each_with_index do |wtb, i|
      allow(wtb).to receive_message_chain(:course_participant, :id).and_return i
    end
    assign :wtbs, wtbs
  end

  it 'renders an array' do
    render
    expect( JSON.parse(rendered) ).to be_an Array
  end

  describe 'time and name conversions' do
    it 'contains "start" as a Y-m-d %H:%M string based on from' do
      render
      expect( parsed.first['start'] ).to eq wtbs.first[:from].strftime("%Y-%m-%d %H:%M")
    end

    it 'contains "end" as a Y-m-d %H:%M string based on to' do
      render
      expect( parsed.first['end'] ).to eq wtbs.first[:to].strftime("%Y-%m-%d %H:%M")
    end
  end

  it 'has the course-participant id' do
    render
    expect( parsed[2]['course_participant_id'] ).to eq 2
  end
end
