# frozen_string_literal: true

require_relative '../lib/jobs_parser'

RSpec.describe JobsParser do
  let(:csv_file_path) { 'spec/fixtures/jobs.csv' }
  let(:jobs_parser) { JobsParser.new(csv_file_path) }

  describe '#results' do
    let(:jobs_parser_result) { jobs_parser.results }

    it 'returns an array of Job objects' do
      expect(jobs_parser_result.size).to eq(2)
      expect(jobs_parser_result.first).to be_a(Job)
      expect(jobs_parser_result.first.id).to eq(1)
      expect(jobs_parser_result.first.title).to eq('')
      expect(jobs_parser_result.first.required_skills).to eq(['Ruby', 'SQL', 'Problem Solving'])
      expect(jobs_parser_result.last).to be_a(Job)
      expect(jobs_parser_result.last.id).to eq(0)
      expect(jobs_parser_result.last.title).to eq('Frontend Developer')
      expect(jobs_parser_result.last.required_skills).to eq([])
    end

    context 'when csv file is empty' do
      let(:csv_file_path) { 'spec/fixtures/empty_jobs.csv' }

      it 'returns empty array' do
        expect(jobs_parser_result).to eq([])
      end
    end
  end
end