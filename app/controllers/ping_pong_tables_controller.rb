class PingPongTablesController < ApplicationController
  def index
    respond_to do |format|
      format.json { render json: PingPongTable.all, status: 200 }
    end
  end
end