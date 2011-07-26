class PlayerController < ApplicationController
  before_filter :check_session, :except => [:identify ]
  before_filter :set_player, :except => [:identify ]
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

      redirect_to :action => :index
    end
  end
  
  def logout
    reset_session
    if @player
      @player.destroy
    end
    redirect_to :action => :index
  end
  
  def nudge_strain
    nudge_generic(:strain)
  end
  
  def nudge_generic(key)
    if params[:nudge].present?
      if params[:nudge].to_i == 1
       @player.increment!(key) 
      else
        @player.decrement!(key) 
      end
    end
  end
  
  def refresh_state
    render :partial => 'player_state_table' 
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