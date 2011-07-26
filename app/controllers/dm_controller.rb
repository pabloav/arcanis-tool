class DmController < ApplicationController
  before_filter :load_players

  def index
  end
  
  # TODO: This needs to move to the DM controller but here for now for debugging
  def tick
    @master_clock.tick!
    refresh
  end
  
  def push
    if params[:player_id].present? and params[:speed].present?
      p = Player.find(params[:player_id])
      p.push!(@master_clock, params[:speed].to_i)
    end
    refresh
  end
  
  def refresh
    load_players
    render :partial => 'dm_table'
  end

  def reset_scene
    @players.each { |p| p.reset! }
    @master_clock.reset!
    refresh
  end

private
  def load_players
    @players = Player.all
  end
  
    
end
