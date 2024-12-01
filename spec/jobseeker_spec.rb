# frozen_string_literal: true

require_relative '../lib/jobseeker'

RSpec.describe Jobseeker do
  let(:jobseeker) { Jobseeker.new(id: id, name: name, skills: skills) }
  let(:id) { 1 }
  let(:name) { 'Alice Seeker' }
  let(:skills) { 'Ruby, SQL, Problem Solving' }

  it 'initializes the jobseeker with the correct attributes' do
    expect(jobseeker.id).to eq(1)
    expect(jobseeker.name).to eq('Alice Seeker')
    expect(jobseeker.skills).to eq(['Ruby', 'SQL', 'Problem Solving'])
  end

  context 'when invalid id' do
    context 'when id is not a number' do
      let(:id) { 'invalid' }

      it 'raises error' do
        expect { jobseeker }.to raise_error(ArgumentError, 'ID must be a positive number')
      end
    end

    context 'when id is a negative number' do
      let(:id) { '-3' }

      it 'raises error' do
        expect { jobseeker }.to raise_error(ArgumentError, 'ID must be a positive number')
      end
    end

    context 'when id is zero' do
      let(:id) { '0' }

      it 'raises error' do
        expect { jobseeker }.to raise_error(ArgumentError, 'ID must be a positive number')
      end
    end

    context 'when id is empty' do
      let(:id) { '' }

      it 'raises error' do
        expect { jobseeker }.to raise_error(ArgumentError, 'ID must be a positive number')
      end
    end
  end

  context 'when name is empty' do
    let(:name) { nil }

    it 'raises error' do
      expect { jobseeker }.to raise_error(ArgumentError, 'Name must exists')
    end
  end

  context 'when required skills is empty' do
    let(:skills) { nil }

    it 'returns empty array' do
      expect(jobseeker.skills).to eq([])
    end
  end
end
