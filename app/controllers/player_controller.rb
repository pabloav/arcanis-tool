class PlayerController < ApplicationController
  before_filter :check_session, :except => [:identify, :current, :current_serial, :current_clock, :action_menu ]
  before_filter :set_player, :except => [:identify, :current, :current_serial, :current_clock, :action_menu ]
  def index
  end
  
  def identify
    if params[:player].present?
      name = params[:player]
      session[:player] = name
      unless Player.find_by_name(name)
        p = Player.new()
        p.name = name
        p.save
      end

      @master_clock.touch!
      redirect_to :action => :index
    end
  end
  
  def logout
    reset_session
    if @player
      @player.destroy
      @master_clock.touch!
    end
    redirect_to :action => :index
  end
  
  
  def refresh
    render :partial => 'player_state_table' 
  end
  
  def perform
    @player.perform!(params[:clock].to_i, params[:speed].to_i, params[:strain].to_i, params[:recovery].to_i)
    @master_clock.touch!
    refresh
  end
  
  def action_menu
    render :partial => 'action_menu'
  end
  
private
  def check_session
    return true if session[:player].present?
    redirect_to :action => :identify
  end
  
  def set_player
    if session[:player].present?
      @player = Player.find_by_name(session[:player])
    end
  end
end
