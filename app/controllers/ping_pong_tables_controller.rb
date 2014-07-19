class PingPongTablesController < ApplicationController
  def index
    center = params[:c]
    edge = params[:e]
    tables = PingPongTable.for_center_and_edge(center, edge)

    respond_to do |format|
      format.json { render json: tables, status: 200 }
    end
  end
end