# frozen_string_literal: true

require_relative '../lib/job'

RSpec.describe Job do
  let(:job) { Job.new(id: id, title: title, required_skills: required_skills) }
  let(:id) { 1 }
  let(:title) { 'Ruby Developer' }
  let(:required_skills) { 'Ruby, SQL, Problem Solving' }

  describe 'initialize' do
    it 'initializes the job with the correct attributes' do
      expect(job.id).to eq(1)
      expect(job.title).to eq('Ruby Developer')
      expect(job.required_skills).to eq(['Ruby', 'SQL', 'Problem Solving'])
    end

    context 'when invalid id' do
      context 'when id is not a number' do
        let(:id) { 'invalid' }

        it 'raises error' do
          expect { job }.to raise_error(ArgumentError, 'ID must be a positive number')
        end
      end

      context 'when id is a negative number' do
        let(:id) { '-10' }

        it 'raises error' do
          expect { job }.to raise_error(ArgumentError, 'ID must be a positive number')
        end
      end

      context 'when id is zero' do
        let(:id) { '0' }

        it 'raises error' do
          expect { job }.to raise_error(ArgumentError, 'ID must be a positive number')
        end
      end

      context 'when id is empty' do
        let(:id) { nil }

        it 'raises error' do
          expect { job }.to raise_error(ArgumentError, 'ID must be a positive number')
        end
      end
    end

    context 'when title is empty' do
      let(:title) { nil }

      it 'raises error' do
        expect { job }.to raise_error(ArgumentError, 'Title must exists')
      end
    end

    context 'when required skills is empty' do
      let(:required_skills) { nil }

      it 'returns empty array' do
        expect(job.required_skills).to eq([])
      end
    end
  end
end
