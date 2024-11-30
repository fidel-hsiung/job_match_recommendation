# frozen_string_literal: true

require_relative '../lib/job_skill_match_evaluator'
require_relative '../lib/jobseeker'
require_relative '../lib/job'

RSpec.describe JobSkillMatchEvaluator do
  let(:job_skill_match_evaluator) { JobSkillMatchEvaluator.new(jobseeker: jobseeker, job: job) }

  describe '#results' do
    let(:evaluator_result) { job_skill_match_evaluator.results }

    context 'when all skills matching' do
      let(:jobseeker) { Jobseeker.new(id: 1, name: 'Alice Seeker', skills: ['Ruby', 'SQL', 'Problem Solving']) }
      let(:job) { Job.new(id: 1, title: 'Ruby Developer', required_skills: ['Ruby', 'SQL', 'Problem Solving']) }

      it 'calculates the correct result' do
        expect(evaluator_result[:matching_count]).to eq(3)
        expect(evaluator_result[:matching_percentage]).to eq(100)
      end
    end

    context 'when part of skills matching' do
      let(:jobseeker) { Jobseeker.new(id: 1, name: 'Alice Seeker', skills: ['Ruby', 'SQL', 'Problem Solving']) }
      let(:job) { Job.new(id: 1, title: 'Ruby Developer', required_skills: ['Java', 'SQL', 'Problem Solving']) }

      it 'calculates the correct result' do
        expect(evaluator_result[:matching_count]).to eq(2)
        expect(evaluator_result[:matching_percentage]).to eq(67)
      end
    end

    context 'when there are no matching skills' do
      let(:jobseeker) { Jobseeker.new(id: 1, name: 'Alice Seeker', skills: ['Ruby', 'SQL', 'Problem Solving']) }
      let(:job) do
        Job.new(id: 1, title: 'Frontend Developer', required_skills: ['JavaScript', 'HTML/CSS', 'React', 'Teamwork'])
      end

      it 'returns 0' do
        expect(evaluator_result[:matching_count]).to eq(0)
        expect(evaluator_result[:matching_percentage]).to eq(0)
      end
    end

    context 'when there are no required skills' do
      let(:jobseeker) { Jobseeker.new(id: 1, name: 'Alice Seeker', skills: ['Ruby', 'SQL', 'Problem Solving']) }
      let(:job) { Job.new(id: 1, title: 'Ruby Developer', required_skills: []) }

      it 'returns 0' do
        expect(evaluator_result[:matching_count]).to eq(0)
        expect(evaluator_result[:matching_percentage]).to eq(0)
      end
    end

    context 'when there are no jobseeker skills' do
      let(:jobseeker) { Jobseeker.new(id: 1, name: 'Alice Seeker', skills: []) }
      let(:job) { Job.new(id: 1, title: 'Ruby Developer', required_skills: ['Java', 'SQL', 'Problem Solving']) }

      it 'returns 0' do
        expect(evaluator_result[:matching_count]).to eq(0)
        expect(evaluator_result[:matching_percentage]).to eq(0)
      end
    end
  end
end
