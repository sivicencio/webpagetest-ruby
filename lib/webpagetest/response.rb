module Webpagetest
  # Custom response class for Webpagetest test data
  class Response

    # Code directly taken from Susuwatari gem. Symbolizes a hash recursively
    def self.deep_symbolize(hsh, &block)
      hsh.inject({}) { |result, (key, value)|
        # Recursively deep-symbolize subhashes
        value = deep_symbolize(value, &block) if value.is_a? Hash

        # Pre-process the key with a block if it was given
        key = yield key if block_given?
        # Symbolize the key string if it responds to to_sym
        sym_key = key.to_sym rescue key

        # write it back into the result and return the updated hash
        result[sym_key] = value
        result
      }
    end
  end


end