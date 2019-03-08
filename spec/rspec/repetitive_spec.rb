RSpec.describe RSpec::Repetitive do
  it "has a version number" do
    expect(RSpec::Repetitive::VERSION).not_to be nil
  end

  describe "repeating examples" do
    repeat_each_example "repeated description prefix" do
      @repeated = true
    end

    before(:context) { @example_run_count = Hash.new(0) }
    before { |example| @example_run_count[example.location] += 1 }

    after(:context) { expect(@example_run_count.values).to all eq 2 }

    it "repeats each example a second time after invoking block" do |example|
      if @example_run_count[example.location] == 1
        expect(defined?(@repeated)).to be nil
      else
        expect(@repeated).to be true
      end
    end

    it "can add a prefix to repeated example descriptions" do |example|
      if @example_run_count[example.location] == 1
        expect(example.description).to eq("can add a prefix to repeated example descriptions")
      else
        expect(example.description).to eq("repeated description prefix can add a prefix to repeated example descriptions")
      end
    end

    describe "nested groups" do
      it "also repeats" do |example|
        if @example_run_count[example.location] == 1
          expect(defined?(@repeated)).to be nil
        else
          expect(@repeated).to be true
        end
      end

      describe "nested repeat_each_example" do
        repeat_each_example { |example| @nested_repeat = true }

        it "clobbers the earlier repeat_each_example" do |example|
          if @example_run_count[example.location] == 1
            expect(defined?(@repeated)).to be nil
            expect(defined?(@nested_repeat)).to be nil
          else
            expect(defined?(@repeated)).to be nil
            expect(@nested_repeat).to be true
          end
        end
      end
    end
  end
end
