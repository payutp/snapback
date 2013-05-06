class ItemsController < ApplicationController
  def return
    item = Item.find(params[:id])
    lend = item.lend
    r = item.return

    r.update_attributes(:status => "returning")

    redirect_to activity_path
  end

  def confirm
    item = Item.find(params[:id])
    lend = item.lend
    r = item.return

    lend.update_attributes(:status => "close")
    r.update_attributes(:status => "close")

    redirect_to activity_path
  end
end
