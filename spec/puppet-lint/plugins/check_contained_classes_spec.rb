require 'spec_helper'

describe 'contained_classes' do
  let(:msg) { 'expected corresponding contain statement' }

  context 'with fix disabled' do
    context 'code contains contain keyword' do
      let(:code) { "class { 'apache': }\ncontain apache\n" }

      it 'should not detect any problems' do
        expect(problems).to have(0).problems
      end
    end

    context 'code not containing the class' do
      let(:code) { "class { 'apache': }\n" }

      it 'should detect a single problem' do
        expect(problems).to have(1).problem
      end

      it 'should create a warning' do
        expect(problems).to contain_warning(msg).on_line(1)
      end
    end

    context 'code containing the class' do
      let(:code) { "class { 'apache': }\ncontain apache\n" }

      it 'should not detect any problems' do
        expect(problems).to have(0).problems
      end
    end
  end

  context 'with fix enabled' do
    before do
      PuppetLint.configuration.fix = true
    end

    context 'code not containing the class' do
      let(:code) { "class {'apache':}" }

      it 'should only detect a single problem' do
        expect(problems).to have(1).problem
      end

      it 'should fix the problem' do
        expect(problems).to contain_fixed(msg).on_line(1)
      end

      it 'should add a newline to the end of the manifest' do
        expect(manifest).to eq("class {'apache':}\ncontain apache")
      end
    end

    context 'code containing the class' do
      let(:code) { "class {'apache':}\ncontain apache" }

      it 'should not detect any problems' do
        expect(problems).to have(0).problems
      end

      it 'should not modify the manifest' do
        expect(manifest).to eq(code)
      end
    end

    after do
      PuppetLint.configuration.fix = false
    end
  end


end
