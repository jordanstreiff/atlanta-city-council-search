class RepresentativesController < ApplicationController
  def index
    search_result = nil
    if params[:address]
      search_result = AddressHelper.get_district_from_address(params[:address])
      @npu = search_result[:npu]
      @council_member = Representative.find_by_district_id(search_result[:district_id])
    end
  end
end