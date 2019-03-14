class TracksController < ApplicationController

  def all
    @tracks = Track.active

    render json: { tracks: @tracks }
  end

end
