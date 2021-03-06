class ChallengesController < ApplicationController

  def index
    @challenges = Challenge.upcoming
  end

  def show
    @challenge = Challenge.find params[:id]
  end

  def new
    @challenge = Challenge.new
  end

  def create
    @challenge = current_user.owned_challenges.build(challenge_params)
    if @challenge.save
      flash[:success] = "Challenge successfully created."
      redirect_to @challenge
    else
      flash.now[:error] = "Error: Challenge not created."
      render :new
    end
  end

  def edit
    @challenge = Challenge.find params[:id]
  end

  def update
    @challenge = Challenge.find params[:id]
    if @challenge.update(challenge_params)
      flash[:success] = "Challenge successfully updated."
      redirect_to @challenge
    else
      flash.now[:error] = "Error: Challenge not updated."
      render :edit
    end
  end

  def destroy
    challenge = Challenge.find params[:id]
    challenge.delete

    flash[:success] = "Challenge destroyed."
    redirect_to challenges_path
  end

  private

  def challenge_params
    params.require(:challenge)
      .permit(:title, :reward, :deadline_time, :deadline_date, :location)
  end

end
