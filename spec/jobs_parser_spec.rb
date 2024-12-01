# frozen_string_literal: true

require_relative '../lib/jobs_parser'

RSpec.describe JobsParser do
  let(:csv_file_path) { 'spec/fixtures/jobs.csv' }
  let(:jobs_parser) { JobsParser.new(csv_file_path) }

  describe '#results' do
    let(:jobs_parser_result) { jobs_parser.results }
    let(:jobs_parser_result_array) { jobs_parser_result.to_a }

    it 'lazily loads jobs' do
      expect(jobs_parser_result).to be_an Enumerator

      jobs = jobs_parser_result.take(1)
      expect(jobs.size).to eq(1)
      expect(jobs.first.id).to eq(1)
      expect(jobs.first.title).to eq('')
      expect(jobs.first.required_skills).to eq(['Ruby', 'SQL', 'Problem Solving'])
    end

    it 'returns an array of Job if calling to_a' do
      expect(jobs_parser_result_array.size).to eq(2)
      expect(jobs_parser_result_array.first).to be_a(Job)
      expect(jobs_parser_result_array.first.id).to eq(1)
      expect(jobs_parser_result_array.first.title).to eq('')
      expect(jobs_parser_result_array.first.required_skills).to eq(['Ruby', 'SQL', 'Problem Solving'])
      expect(jobs_parser_result_array.last).to be_a(Job)
      expect(jobs_parser_result_array.last.id).to eq(0)
      expect(jobs_parser_result_array.last.title).to eq('Frontend Developer')
      expect(jobs_parser_result_array.last.required_skills).to eq([])
    end

    context 'when csv file is empty' do
      let(:csv_file_path) { 'spec/fixtures/empty_jobs.csv' }

      it 'returns empty array' do
        expect(jobs_parser_result_array).to eq([])
      end
    end

    context 'when the csv file is invalid' do
      let(:csv_file_path) { 'spec/fixtures/nonexistent_jobs.csv' }

      it 'raises an error' do
        allow(jobs_parser).to receive(:log_error)

        jobs_parser_result_array

        expect(jobs_parser).to have_received(:log_error).with(
          a_string_including("Error while parsing the jobs CSV file(#{csv_file_path}):")
        )
      end
    end
  end
end
