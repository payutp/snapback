class ItemsController < ApplicationController
  def return
    item = Item.find(params[:id])
    lend = item.lend
    r = item.return

    r.update_attributes(:status => "returning")

    redirect_to activity_path
  end

  def confirm_form 
    @item = Item.find(params[:id])

    respond_to do |format|
      format.js {}
    end
  end 

  def confirm
    item = Item.find(params[:id])
    lend = item.lend
    r = item.return

    lend.update_attributes(:status => "close")
    r.update_attributes(:status => "close")

    lenduser = lend.user
    current_date = DateTime.now 
    return_date = r.reminder.return_date
    lenduser.update_rating(current_date, return_date)

    score = params[:score]
    score = score.to_i
    if score != 0
      lenduser.update_rating_manual(score)
    end

    redirect_to activity_path
  end
end
