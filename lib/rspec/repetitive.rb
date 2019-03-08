require "rspec/repetitive/version"

module RSpec
  module Repetitive
    def self.configure(configuration)
      configuration.extend(self)

      configuration.on_example_group_definition do |top_level_example_group|
        tagged_examples(top_level_example_group, :"rspec-repetitive_before_block").each do |example|
          new_description = example.metadata[:"rspec-repetitive_example_description_prefix"] + " " + example.description

          register_example_from_source_example(example, new_description) do |old_block, *args|
            instance_exec(*args, &example.metadata[:"rspec-repetitive_before_block"])
            instance_exec(*args, &old_block)
          end
        end
      end
    end

    def self.register_example_from_source_example(source_example, description, &around_example_block)
      example_block = if block_given?
        ->(*args) { instance_exec(source_example.metadata[:block], *args, &around_example_block) }
      else
        source_example.metadata[:block]
      end

      new_metadata = Hash[source_example.metadata.reject { |k, v| RSpec::Core::Metadata::RESERVED_KEYS.include?(k) }].
        merge(:caller => [source_example.metadata[:block].source_location.join(":")])

      RSpec::Core::Example.new(source_example.example_group, description, new_metadata, example_block)
    end

    def self.tagged_examples(example_group, tag)
      _each_example(example_group).select { |example| example.metadata[tag] }.to_a
    end

    def self._each_example(example_group, &block)
      return enum_for(:_each_example, example_group) unless block_given?

      example_group.examples.each(&block)
      example_group.children.each { |child_example_group| _each_example(child_example_group, &block) }
    end

    def repeat_each_example(example_description_prefix = "", &block)
      metadata[:"rspec-repetitive_before_block"] = block
      metadata[:"rspec-repetitive_example_description_prefix"] = example_description_prefix
    end
  end
end
