# eileensnotes.com - online Q&A site for everyone who enjoys learning
#
# *** Ideas are worthless unless they are executes
# *** Focus on the things that matter
#
# Programmed by Jae Lee
#
# Last updated on 11/4/2014
# - handle "Record not found" exception
#

class AnswersController < ApplicationController
  # make sure user has been authorized
  before_action :authenticate_user!, :except => [:index, :show]
  
  
  # GET notes/:note_id/answers
  def index
    @note = Note.find_note(params[:note_id])
    if (@note == nil)
      redirect_to notes_url, :notice => "The record was not found."
    else  
      # show all answers if current user is the author of a given question
      # show public answers + user's answers if current user is not the author of a given question
      if (current_user == nil)
        @answers = @note.answers.find_all_public_answers
      else
        if (current_user.id == @note.user_id)
          @answers = @note.answers.find_all_answers
        else
          @answers = @note.answers.find_all_public_user_answers(current_user.id)
        end
      end
      # calling index.html.erb
    end
  end

  # GET notes/:note_id/answers/new
  def new
    @note = Note.find_note(params[:note_id])
    if (@note == nil)
      redirect_to notes_url, :notice => "The record was not found."
    else
      @answer = @note.answers.build
      # calling new.html.erb
    end
  end

  # GET notes/:note_id/answers/:id/edit
  def edit
    @note = Note.find_note(params[:note_id])
    if (@note == nil)
      redirect_to notes_url, :notice => "The record was not found."
    else
      @answer = @note.answers.find(params[:id])
    end
  end

  # POST /notes/:note_id/answers
  def create
    @note = Note.find(params[:note_id])
    @answer = @note.answers.build(answer_params)
    @answer.user_id = current_user.id
    if @answer.save
      @note.touch
      # send an email notification
      AnswerMailer.notify_owner(@note, note_answers_url).deliver
      redirect_to note_answers_url, :notice => "Your answer was posted. Thank you!"
    else
      render :action => "new"
    end
  end

  # PUT /notes/:note_id/answers/:id
  def update
    @note = Note.find(params[:note_id])
    @answer = @note.answers.find(params[:id])
    if current_user.id == @answer.user_id
      if @answer.update(answer_params)
        # send an email notificaiton
        AnswerMailer.notify_owner(@note, note_answers_url).deliver
        redirect_to note_answers_url, :notice => "Your answer was successfully updated. Thank you!"
      else
        render :action => "edit"
      end
    else
      redirect_to note_answers_url, :notice => "Aborted. You don't seem to be the owner of this answer!"
    end
  end

  # /notes/:note_id/answers/:id
  def destroy
    @note = Note.find(params[:note_id])
    @answer = @note.answers.find(params[:id])
    if @answer.user_id == current_user.id
      @answer.destroy
      redirect_to note_answers_url, :notice => "Successfully deleted your answer."
    else
      redirect_to note_answers_url, :notice => "Aborted. You don't seem to be the owner of this answer!"
    end
  end
  
  #
  # private methods
  #
  private
  
  def answer_params
    params.require(:answer).permit(:answer, :is_private) 
  end
  
end
