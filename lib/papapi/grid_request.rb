module Papapi
  require_relative 'request'
  class GridRequest < Request
    DEFAULT_LIMIT = 30

    attr_accessor :sort_col, :sort_asc, :offset, :limit

    def add_filter(code, op, value)
      @filters = [] if ! @filters
      @filters << [code , op, value]
    end

    def response(http_response)
      GridResponse.new(http_response, self)
    end

    def add_column(column)
      @columns = [['id']] if ! @columns
      @columns << [column]
    end

    def set_sorting(column, sort_asc)
      @sort_col = column
      @sort_asc = sort_asc
    end

    def to_data
      data = super
      data[:filters] = @filters || []
      data[:columns] = @columns || []
      data[:sort_col] = @sort_col || ""
      data[:sort_asc] = @sort_asc ? true : false
      data[:offset] = @offset || 0
      data[:limit] = @limit || DEFAULT_LIMIT
      data
    end

  end
end