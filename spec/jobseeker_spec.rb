# frozen_string_literal: true

require_relative '../lib/jobseeker'

RSpec.describe Jobseeker do
  let(:jobseeker) { Jobseeker.new(id: 1, name: 'Alice Seeker', skills: 'Ruby, SQL, Problem Solving') }

  it 'initializes the jobseeker with the correct attributes' do
    expect(jobseeker.id).to eq(1)
    expect(jobseeker.name).to eq('Alice Seeker')
    expect(jobseeker.skills).to eq(['Ruby', 'SQL', 'Problem Solving'])
  end

  context 'when params are empty' do
    let(:jobseeker) { Jobseeker.new(id: nil, name: nil, skills: nil) }

    it 'initializes the jobseeker with empty attributes' do
      expect(jobseeker.id).to eq(0)
      expect(jobseeker.name).to eq('')
      expect(jobseeker.skills).to eq([])
    end
  end
end
