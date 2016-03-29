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

class NotesController < ApplicationController
  # make sure user has been authorized
  before_action :authenticate_user!, :except => [:index, :show, :get_unanswered_notes, :get_user_notes, :get_tagged_notes]
  
  # GET /notes
  def index
    page = params[:page] || 1
    if params[:search].blank?
      @notes = Note.find_all_notes(page)
    else
      @notes = Note.full_text_search(params[:search], page)
    end
    # calling index.html.erb
  end

  # GET /notes/1
  def show
    @note = Note.find_note(params[:id])
    if (@note == nil)
      redirect_to notes_url, :notice => "The record was not found."
    end
    # calling show.html.erb
  end

  # GET /notes/new
  def new
    @note = Note.new
    # calling new.html.erb
  end

  # GET /notes/1/edit
  def edit
    @note = current_user.notes.find(params[:id])
    rescue ActiveRecord::RecordNotFound
      # no record is found
      redirect_to notes_url, :notice => "The record was not found."
    # calling edit.html.erb  
  end

  # POST /notes
  def create
    # this is called from [submit] in new.html.erb
    @note = current_user.notes.build(note_params)
    
    if @note.save
      redirect_to notes_url, :notice => "You have successfully posted your question."
    else
      render :action => "new"
    end
  end

  # PUT /notes/1
  def update
    @note = current_user.notes.find(params[:id])
    # all attributes here must be explicitly assigned
    if @note.update(note_params)
      redirect_to notes_url, :notice => "You have successfully updated your question."
    else
      render :action => "edit"
    end
  end

  # DELETE /notes/1
  def destroy
    # if there is any answer attached to it, user can NOT delete this Q&A
    # so, this Q&A is clean to delete - no answers attached to it
    # here, this Q&A and any reviews will be deleted
    note_id = params[:id]
    @note = current_user.notes.find(params[:id])
    @note.destroy
    redirect_to notes_path, :notice => "You have successfully deleted your question."
  end 
  
  #
  # all other functions that are not CRUD
  #
  
  def get_unanswered_notes
    page = params[:page] || 1
    @notes = Note.find_all_unanswered(page)
    render :action => "index"
  end
  
  def get_user_notes
    page = params[:page] || 1
    @notes = Note.find_by_user(params[:id], page)
    render :action => "index"
  end
  
  def get_tagged_notes
    page = params[:page] || 1
    @notes = Note.find_by_tag(params[:tag], page)
    render :action => "index"
  end
  
  #
  # private methods
  #
  private
  
  def note_params
    params.require(:note).permit(:question, :tag_list) 
  end


end
