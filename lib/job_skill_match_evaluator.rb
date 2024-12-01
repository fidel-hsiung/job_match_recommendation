# frozen_string_literal: true

class JobSkillMatchEvaluator
  attr_reader :jobseeker, :job

  def initialize(jobseeker:, job:)
    @jobseeker = jobseeker
    @job = job
  end

  def results
    matching_skills_count = matching_skills.size
    required_skills_count = job.required_skills.size

    return { matching_count: 0, matching_percentage: 0 } if required_skills_count.zero?

    matching_percentage = calculate_matching_percentage(matching_skills_count, required_skills_count)

    {
      matching_count: matching_skills_count,
      matching_percentage: matching_percentage
    }
  end

  private

  def matching_skills
    jobseeker.skills & job.required_skills
  end

  def calculate_matching_percentage(matching_count, total_count)
    ((matching_count.to_f / total_count) * 100).round
  end
end
