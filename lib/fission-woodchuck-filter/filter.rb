module Fission
  # Woodchuck filter
  module WoodchuckFilter
    # Common action filter for woodchuck payloads
    class Filter < Fission::Callback

      # Valid filters
      FILTERS = [:status_tagger]
      # Valid status tag strings
      STATUS_TAGS = %w(DEBUG INFO WARN ERROR FATAL)

      # Validity of message
      #
      # @param message [Carnivore::Message]
      # @return [Truthy, Falsey]
      def valid?(message)
        super do |m|
          m.get(:data, :woodchuck, :entry)
        end
      end

      # Apply enabled filters to payload
      #
      # @param message [Carnivore::Message]
      def execute(message)
        failure_wrap(message) do |payload|
          enabled = Carnivore::Config.get(:fission, :woodchuck_filter, :enabled) || []
          enabled.each do |filter_name|
            if(FILTERS.include?(filter_name.to_sym))
              send(filter_name, payload)
            end
          end
          completed(payload, message)
        end
      end

      # Add tags based on content of entry. (:debug, :info,
      # :warn, :error, :fatal)
      #
      # @param payload [Hash]
      # @return [TrueClass]
      def status_tagger(payload)
        result = payload.get(:data, :woodchuck, :entry, :content).
          scan(/\b#{STATUS_TAGS.join('|')}\b/)
        if(result.size > 1)
          error "Multiple status match detected within #{message}. Not tagging (matched: #{result.inspect})"
        elsif(result.size == 1)
          payload.get(:data, :woodchuck, :entry, :tags).push(
            result.first.downcase.to_sym
          ).uniq!
        end
        true
      end

    end
  end
end

Fission.register(:woodchuck_filter, :filter, Fission::WoodchuckFilter::Filter)
