# frozen_string_literal: true

module Types
  include Dry::Types.module

  Numeric = Types.Instance(::Numeric)

  FilledHash = Types::Hash.constrained(filled: true)

  FilledArray = Types::Array.constrained(filled: true)

  TrimmedString = Types::String.constructor do |str|
    str.try(:strip).try { tap(&:chomp!) }
  end

  TrimmedStringWithNormalizedWhitespace = Types::String.constructor do |value|
    TrimmedString[value].try { tap { |str| str.gsub!(/\s+/, ' ') } }
  end

  module DistributionPoint
    SerializedParams = Types::Strict::String.constrained(
      format: /\A.+\s.+\s\d+(\.\d{1,2})?\z/
    )
  end
end
