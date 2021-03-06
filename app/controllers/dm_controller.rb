class DmController < ApplicationController
  before_filter :load_players

  def index
  end
  
  def tick
    @master_clock.tick!
    refresh
  end
  
  def push
    if params[:player_id].present? and params[:speed].present?
      p = Player.find(params[:player_id])
      p.push!(@master_clock, params[:speed].to_i)
      @master_clock.touch!
    end
    refresh
  end
  
  def reset_scene
    @players.each do |p| 
      if p.npc?
        p.destroy
      else
        p.reset! 
      end
    end
    
    @master_clock.reset!
    refresh
  end
  
  def perform
    if params[:player_id].present?
      @player = Player.find(params[:player_id])
      @player.perform!(params[:clock].to_i, params[:speed].to_i, params[:strain].to_i, params[:recovery].to_i)
      @master_clock.touch!
    end
    refresh
  end
  
  def kill
    if params[:player_id].present?
      Player.find(params[:player_id]).destroy
    end
    refresh
  end
  
  def add_monster
    if params[:monster_name].present?
      p = Player.new
      p.name = params[:monster_name]
      p.npc = true
      p.clock = params[:initiative].to_i || @master_clock.clock
      p.save
    end
    refresh
    # render :text => "ok"
  end

  def refresh
    load_players
    render :partial => 'dm_table'
  end

private
  def load_players
    @players = Player.all
  end
  
    
end
