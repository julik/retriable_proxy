require File.expand_path(File.dirname(__FILE__) + '/spec_helper')

require_relative "spec_helper"

describe RetriableProxy do
  
  describe '.for_object' do
    it 'wraps the object with a Retriable' do
      w = described_class.for_object(:symbol_to_wrap)
      expect(w).to be_kind_of(RetriableProxy::Wrapper)
    end
  end
  
  describe 'RetriableProxy::Wrapper' do
    let(:subject) { RetriableProxy::Wrapper }
    
    it 'returns the wrapped object via __setobj__' do
      item = :foo
      wrapped = subject.new(item)
      expect(wrapped).to be_kind_of(subject)
      unwrapped = wrapped.__getobj__
      expect(unwrapped).to be_kind_of(Symbol)
    end
  
    it 'supports setting retrying methods explicitly' do
      raising_class = Class.new do
        def self.perform_failing_operation
          @tries_failing ||= 0
          @tries_failing += 1
          raise StandardError.new if @tries_failing < 3
          "success"
        end
      
        def self.perform_non_retrying_operation
          @tries_non_retrying ||= 0
          @tries_non_retrying += 1
          raise StandardError.new if @tries_non_retrying < 2 
        end
      end
    
      wrapped_raising_class = subject.new(raising_class, methods: [:perform_failing_operation])
      expect(wrapped_raising_class.perform_failing_operation).to eq("success")
    
      expect {
        wrapped_raising_class.perform_non_retrying_operation
      }.to raise_error(StandardError)
    end
  
    it "makes 3 tries when retrying block of code raising StandardError with no arguments" do
      $tries = 0
    
      raising_class = Class.new do
        def self.perform_failing_operation
          $tries += 1
          raise StandardError.new
        end
      end
    
      expect {
        wrapped_raising_class = subject.new(raising_class, {})
        wrapped_raising_class.perform_failing_operation
      }.to raise_error(StandardError)
    
      expect($tries).to eq(3)
    end
  end
end

