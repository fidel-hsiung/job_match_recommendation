# frozen_string_literal: true

require_relative '../lib/jobseekers_parser'

RSpec.describe JobseekersParser do
  let(:csv_file_path) { 'spec/fixtures/jobseekers.csv' }
  let(:jobseekers_parser) { JobseekersParser.new(csv_file_path) }

  describe '#results' do
    let(:jobseekers_parser_result) { jobseekers_parser.results }
    let(:jobseekers_parser_result_array) { jobseekers_parser_result.to_a }

    it 'lazily loads jobseekers' do
      expect(jobseekers_parser_result).to be_an Enumerator

      jobseekers = jobseekers_parser_result.take(1)
      expect(jobseekers.size).to eq(1)
      expect(jobseekers.first.id).to eq(0)
      expect(jobseekers.first.name).to eq('Alice Seeker')
      expect(jobseekers.first.skills).to eq([])
    end

    it 'returns an array of Jobseeker if calling to_a' do
      expect(jobseekers_parser_result_array.size).to eq(2)
      expect(jobseekers_parser_result_array.first).to be_a(Jobseeker)
      expect(jobseekers_parser_result_array.first.id).to eq(0)
      expect(jobseekers_parser_result_array.first.name).to eq('Alice Seeker')
      expect(jobseekers_parser_result_array.first.skills).to eq([])
      expect(jobseekers_parser_result_array.last).to be_a(Jobseeker)
      expect(jobseekers_parser_result_array.last.id).to eq(2)
      expect(jobseekers_parser_result_array.last.name).to eq('')
      expect(jobseekers_parser_result_array.last.skills).to eq(['JavaScript', 'HTML/CSS', 'Teamwork'])
    end

    context 'when the csv file is empty' do
      let(:csv_file_path) { 'spec/fixtures/empty_jobseekers.csv' }

      it 'returns empty array' do
        expect(jobseekers_parser_result_array).to eq([])
      end
    end

    context 'when the csv file is invalid' do
      let(:csv_file_path) { 'spec/fixtures/nonexistent_jobseekers.csv' }

      it 'raises an error' do
        allow(jobseekers_parser).to receive(:puts)

        jobseekers_parser_result_array

        expect(jobseekers_parser).to have_received(:puts).with(
          a_string_including("Error while parsing the jobseekers CSV file(#{csv_file_path}):")
        )
      end
    end
  end
end
