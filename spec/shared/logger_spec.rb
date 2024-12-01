# frozen_string_literal: true

require_relative '../../lib/shared/logger'

class TestLogger
  include Shared::Logger
end

RSpec.describe Shared::Logger do
  before do
    allow(logger).to receive(:puts)
  end

  let(:logger) { TestLogger.new }
  let(:message) { 'Test message' }

  describe '#log' do
    it 'puts the message' do
      logger.log(message)

      expect(logger).to have_received(:puts).with("[LOG] #{message}")
    end
  end

  describe '#log_error' do
    it 'puts the error message' do
      logger.log_error(message)

      expect(logger).to have_received(:puts).with("[ERROR] #{message}")
    end
  end
end
