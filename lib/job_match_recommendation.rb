# frozen_string_literal: true

require_relative 'jobseekers_parser'
require_relative 'jobs_parser'
require_relative 'job_skill_match_evaluator'

class JobMatchRecommendation
  def initialize(jobseekers_file:, jobs_file:)
    @jobseekers_file = jobseekers_file
    @jobs_file = jobs_file
  end

  def results
    recommendations = []

    jobseekers.each do |jobseeker|
      jobs.each do |job|
        job_skill_match_evaluate_results = JobSkillMatchEvaluator.new(jobseeker: jobseeker, job: job).results

        next unless job_skill_match_evaluate_results[:matching_count] > 0

        recommendations << {
          jobseeker_id: jobseeker.id,
          jobseeker_name: jobseeker.name,
          job_id: job.id,
          job_title: job.title,
          matching_skill_count: job_skill_match_evaluate_results[:matching_count],
          matching_skill_percent: job_skill_match_evaluate_results[:matching_percentage]
        }
      end
    end

    result = recommendations.sort_by do |recommendation|
      [recommendation[:jobseeker_id], -recommendation[:matching_skill_percent], recommendation[:job_id]]
    end

    result
  end

  def jobseekers
    @jobseekers ||= JobseekersParser.new(@jobseekers_file).results
  end

  def jobs
    @jobs ||= JobsParser.new(@jobs_file).results
  end
end