# frozen_string_literal: true

require_relative "./tn_congress/version"
require_relative "./tn_congress/cli"
require_relative "./tn_congress/scraper"
require_relative "./tn_congress/rep"
require_relative "./tn_congress/bill"

module TnCongress
  class Error < StandardError; end
  # Your code goes here...
end
