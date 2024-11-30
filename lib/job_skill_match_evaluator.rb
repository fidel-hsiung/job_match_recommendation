# frozen_string_literal: true

class JobSkillMatchEvaluator
  attr_reader :jobseeker, :job

  def initialize(jobseeker:, job:)
    @jobseeker = jobseeker
    @job = job
  end

  def results
    matching_skills_count = (jobseeker.skills & job.required_skills).size
    required_skills_count = job.required_skills.size

    matching_skills_percentage = if required_skills_count.zero?
      0
    else
      ((matching_skills_count.to_f / required_skills_count) * 100).round
    end

    {
      matching_count: matching_skills_count,
      matching_percentage: matching_skills_percentage
    }
  end
end
