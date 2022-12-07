module FetchPage
  extend ActiveSupport::Concern

  module ClassMethods
    def fetch_page(options = {})
      basic_options(options)
      collections = where(nil)
      execute(collections)
    end

    def basic_options(options = {})
      order_by = options.fetch(:order_by, 'updated_at').to_s
      order_direction = options.fetch(:order_direction, :desc).to_sym
      @order_by = column_names.include?(order_by) ? order_by : 'updated_at'
      @order_direction = %i[desc asc].include?(order_direction) ? order_direction : :desc
      @order = Arel.sql("#{table_name}.#{@order_by} #{@order_direction}")
      @page = options.fetch(:page, nil)
      @per = options.fetch(:per, nil)
      @options = options
    end

    def execute(collections)
      collections = collections.reorder(@order) if @order_by != 'updated_at'
      collections = collections.page(@page).per(@per) if @page.to_i.positive? && @per.to_i.positive?
      collections
    end
  end
end
