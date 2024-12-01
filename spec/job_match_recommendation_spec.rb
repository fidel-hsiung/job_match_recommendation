# frozen_string_literal: true

require_relative '../lib/job_match_recommendation'

RSpec.describe JobMatchRecommendation do
  let(:jobseekers_file) { 'spec/fixtures/jobseekers.csv' }
  let(:jobs_file) { 'spec/fixtures/jobs.csv' }
  let(:job_match_recommendation) { JobMatchRecommendation.new(jobseekers_file: jobseekers_file, jobs_file: jobs_file) }
  let(:jobseekers) do
    [
      Jobseeker.new(id: 1, name: 'Alice Seeker', skills: 'Ruby, SQL, Problem Solving'),
      nil,
      Jobseeker.new(id: 2, name: 'Bob Applicant', skills: 'JavaScript, HTML/CSS, Teamwork'),
      '',
      Jobseeker.new(id: 3, name: 'Charlie Jobhunter', skills: 'Java, SQL, Problem Solving')
    ]
  end
  let(:jobs) do
    [
      Job.new(id: 1, title: 'Ruby Developer', required_skills: 'Ruby, SQL, Problem Solving'),
      Job.new(id: 2, title: 'Frontend Developer', required_skills: 'JavaScript, HTML/CSS, React, Teamwork'),
      nil,
      '',
      Job.new(id: 3, title: 'Backend Developer', required_skills: 'Java, SQL, Node.js, Problem Solving'),
      Job.new(id: 4, title: 'Web Developer', required_skills: 'HTML/CSS, JavaScript, Ruby, Teamwork')
    ]
  end

  before do
    allow(JobseekersParser)
      .to receive(:new).with(jobseekers_file).and_return(instance_double(JobseekersParser, results: jobseekers))
    allow(JobsParser).to receive(:new).with(jobs_file).and_return(instance_double(JobsParser, results: jobs))
  end

  describe '#results' do
    let(:recommendation_result) { job_match_recommendation.results }

    context 'when there are job matches' do
      let(:expected_recommendations) do
        [
          {
            jobseeker_id: 1,
            jobseeker_name: 'Alice',
            job_id: 1,
            job_title: 'Ruby Developer',
            matching_skill_count: 3,
            matching_skill_percent: 100
          },
          {
            jobseeker_id: 1,
            jobseeker_name: 'Alice',
            job_id: 3,
            job_title: 'Backend Developer',
            matching_skill_count: 2,
            matching_skill_percent: 50
          },
          {
            jobseeker_id: 1,
            jobseeker_name: 'Alice',
            job_id: 4,
            job_title: 'Web Developer',
            matching_skill_count: 1,
            matching_skill_percent: 25
          },
          {
            jobseeker_id: 2,
            jobseeker_name: 'Bob',
            job_id: 2,
            job_title: 'Frontend Developer',
            matching_skill_count: 3,
            matching_skill_percent: 75
          },
          {
            jobseeker_id: 2,
            jobseeker_name: 'Bob',
            job_id: 4,
            job_title: 'Web Developer',
            matching_skill_count: 3,
            matching_skill_percent: 75
          },
          {
            jobseeker_id: 3,
            jobseeker_name: 'Charlie',
            job_id: 3,
            job_title: 'Backend Developer',
            matching_skill_count: 3,
            matching_skill_percent: 75
          },
          {
            jobseeker_id: 3,
            jobseeker_name: 'Charlie',
            job_id: 1,
            job_title: 'Ruby Developer',
            matching_skill_count: 2,
            matching_skill_percent: 67
          }
        ]
      end

      it 'skips the empty jobseeker/job and lists the recommendations in expected sorting' do
        expect(recommendation_result).to eq(expected_recommendations)
      end
    end

    context 'when there are no job matches' do
      let(:jobs) do
        [Job.new(id: 5, title: 'ML Engineer', required_skills: 'Python, Machine Learning, Adaptability')]
      end

      it 'does not recommend any jobs' do
        expect(recommendation_result).to be_empty
      end
    end

    context 'when no jobseekers provided' do
      let(:jobseekers) { [] }

      it 'does not recommend any jobs' do
        expect(recommendation_result).to be_empty
      end
    end
  end
end
