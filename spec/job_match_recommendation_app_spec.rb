# frozen_string_literal: true

require_relative '../lib/job_match_recommendation_app'

RSpec.describe JobMatchRecommendationApp do
  let(:jobseekers_csv) { 'spec/fixutres/jobseekers.csv' }
  let(:jobs_csv) { 'spec/fixutres/jobs.csv' }
  let(:app) { JobMatchRecommendationApp.new }

  describe '#initialize' do
    describe '#set_csv_paths' do
      context 'when no argvs passed' do
        it 'uses default csvs' do
          app = JobMatchRecommendationApp.new

          expect(app.jobseekers_csv_path).to eq JobMatchRecommendationApp::DEFAULT_JOBSEEKERS_CSV
          expect(app.jobs_csv_path).to eq JobMatchRecommendationApp::DEFAULT_JOBS_CSV
        end
      end

      context 'when valid CSV file paths are provided' do

        it 'uses default csvs' do
          app = JobMatchRecommendationApp.new
          app.instance_variable_set(:@options, { jobseekers_csv: jobseekers_csv, jobs_csv: jobs_csv })
          app.send(:set_csv_paths)

          expect(app.jobseekers_csv_path).to eq jobseekers_csv
          expect(app.jobs_csv_path).to eq jobs_csv
        end
      end
    end

    describe '#validate_csv_paths' do
      context 'when paths are valid' do
        it 'does not add errors' do
          app.instance_variable_set(:@options, { jobseekers_csv: jobseekers_csv, jobs_csv: jobs_csv })
          app.send(:validate_csv_paths)

          expect(app.errors).to be_empty
        end
      end

      context 'when paths are invalid' do
        let(:invalid_jobseekrs_csv) { 'spec/fixtures/nonexist_jobseekers.csv' }
        let(:invalid_jobs_csv) { 'spec/fixtures/nonexist_jobs.csv' }

        it 'adds errors for invalid csvs' do
          app.instance_variable_set(:@options, { jobseekers_csv: invalid_jobseekrs_csv, jobs_csv: invalid_jobs_csv })
          app.send(:set_csv_paths)
          app.send(:validate_csv_paths)

          expect(app.errors).to eq [
            "#{invalid_jobseekrs_csv} does not exist or is not a valid file", "#{invalid_jobs_csv} does not exist or is not a valid file"
          ]
        end
      end
    end

    describe '#run' do
      context 'when there are errors' do
        before do
          allow(app).to receive(:errors).and_return(['error'])
        end

        it 'exits' do
          expect { app.run }.to raise_error(SystemExit)
        end
      end

      context 'when there are no errors' do
        before do
          allow(JobMatchRecommendation).to receive(:new).and_return(job_match_recommendation)

          allow(app).to receive(:puts)
        end

        let(:job_match_recommendation) do
          instance_double(JobMatchRecommendation, results: [
            {
              jobseeker_id: 1,
              jobseeker_name: 'Alice Seeker',
              job_id: 1,
              job_title: 'Ruby Developer',
              matching_skill_count: 3,
              matching_skill_percent: 100
            }
          ])
        end

        it 'outputs job recommendations' do
          app.run

          expect(app).to have_received(:puts).with('Job recommendations generated successfully.')
          expect(app).to have_received(:puts).with('jobseeker_id, jobseeker_name, job_id, job_title, matching_skill_count, matching_skill_percent')
          expect(app).to have_received(:puts).with('1, Alice Seeker, 1, Ruby Developer, 3, 100')
        end

        context 'when there are no recommendations' do
          let(:job_match_recommendation) { instance_double(JobMatchRecommendation, results: []) }

          it 'outputs job recommendations' do
            app.run

            expect(app).to have_received(:puts).with('No job recommendations found.')
          end
        end
      end
    end
  end
end