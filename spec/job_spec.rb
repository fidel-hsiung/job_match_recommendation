# frozen_string_literal: true

require_relative '../lib/job'

RSpec.describe Job do
  let(:job) { Job.new(id: 1, title: 'Ruby Developer', required_skills: 'Ruby, SQL, Problem Solving') }

  it 'initializes the job with the correct attributes' do
    expect(job.id).to eq(1)
    expect(job.title).to eq('Ruby Developer')
    expect(job.required_skills).to eq(['Ruby', 'SQL', 'Problem Solving'])
  end

  context 'when params are empty' do
    let(:job) { Job.new(id: nil, title: nil, required_skills: nil) }

    it 'initializes the job with empty attributes' do
      expect(job.id).to eq(0)
      expect(job.title).to eq('')
      expect(job.required_skills).to eq([])
    end
  end
end
