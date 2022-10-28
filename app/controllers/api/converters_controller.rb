class Api::ConvertersController < Api::BaseController
  def convert
    @converter = Converter.new from_amount: params[:from_amount], from_unit: params[:from_unit], to_unit: params[:to_unit]
    @error_object = @converter.errors.messages unless @converter.valid?
    if @error_object.blank?
      render json: { to_unit: @converter.to_unit, to_amount: @converter.to_amount }
    else
      render json: { error: @error_object }, status: :bad_request
    end
  end
end
