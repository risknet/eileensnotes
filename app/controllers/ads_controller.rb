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

class AdsController < ApplicationController
  # make sure user has been authorized
  before_action :authenticate_user!, :except => [:index, :show, :get_tagged_ads]
  
  # GET /notes
  def index
    page = params[:page] || 1
    if params[:search].blank?
      @ads = Ad.find_all_ads(page)
    else
      @ads = Ad.full_text_search(params[:search], page)
    end
    # calling index.html.erb
  end
  
  # GET /ads/1
  def show
    @ad = Ad.find_ad(params[:id])
    if (@ad == nil)
      redirect_to ads_url, :notice => "The record was not found."
    end
    # calling show.html.erb
  end

  # GET /ads/new
  def new
    @ad = Ad.new
    # calling new.html.erb
  end

  # GET /ads/1/edit
  def edit
    @ad = current_user.ads.find(params[:id])
    rescue ActiveRecord::RecordNotFound
      # there is no such record
      redirect_to ads_url, :notice => "The record was not found."
    # calling edit.html.erb
  end

  # POST /ads
  def create
    # this is called from [submit] in new.html.erb
    @ad = current_user.ads.build(ad_params)
    @ad.confirmed = false
    if @ad.save
      redirect_to ads_url, :notice => "Your Advertisement has been successfully posted. Thank you!"
    else
      render :action => "new"
    end
  end
  
  # PUT /ads/1
  def update
    @ad = current_user.ads.find(params[:id])
    if @ad.update(ad_params)
      redirect_to ads_url, :notice => "Your Advertisement has been successfully updated. Thank you!"
    else
      render :action => "edit"
    end
  end

  # DELETE /ads/1
  def destroy
    @ad = current_user.ads.find(params[:id])
    @ad.destroy
    redirect_to ads_url, :notice => "Successfully deleted yours."
  end 
  
  #
  # all other functions that are not CRUD
  #
  
  def get_tagged_ads
    page = params[:page] || 1
    @ads = Ad.find_by_tag(params[:tag], page)
    render :action => "index"
  end
  
  
  #
  # private methods
  #
  private
  
  def ad_params
    params.require(:ad).permit(:ad_title, :ad_content, :tag_list) 
  end
  
end
