# frozen_string_literal: true

require_relative '../lib/jobseekers_parser'

RSpec.describe JobseekersParser do
  let(:csv_file_path) { 'spec/fixtures/jobseekers.csv' }
  let(:jobseekers_parser) { JobseekersParser.new(csv_file_path) }

  describe '#results' do
    let(:jobseekers_parser_result) { jobseekers_parser.results }

    it 'returns an array of Jobseeker objects' do
      expect(jobseekers_parser_result.size).to eq(2)
      expect(jobseekers_parser_result.first).to be_a(Jobseeker)
      expect(jobseekers_parser_result.first.id).to eq(0)
      expect(jobseekers_parser_result.first.name).to eq('Alice Seeker')
      expect(jobseekers_parser_result.first.skills).to eq([])
      expect(jobseekers_parser_result.last).to be_a(Jobseeker)
      expect(jobseekers_parser_result.last.id).to eq(2)
      expect(jobseekers_parser_result.last.name).to eq('')
      expect(jobseekers_parser_result.last.skills).to eq(['JavaScript', 'HTML/CSS', 'Teamwork'])
    end

    context 'when csv file is empty' do
      let(:csv_file_path) { 'spec/fixtures/empty_jobseekers.csv' }

      it 'returns empty array' do
        expect(jobseekers_parser_result).to eq([])
      end
    end
  end
end