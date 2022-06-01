class ItemsController < ApplicationController
    before_action :find_item, only: [:show, :edit, :update, :destroy, :complete]
    def index
        if user_signed_in?
            @items = Item.where(:user_id => current_user.id).order("created_at DESC")
        end
    end

    def show
        
    end

    def new
        @item = current_user.items.build
    end

    def create

        @item = current_user.items.build(item_params)
        respond_to do |format|
            if @item.save
                format.html{redirect_to root_path}
            else
                render 'new'
            end
        end
    end


    def edit

    end

    def update
        respond_to do |format|
            if @item.update(item_params)
                format.html { redirect_to item_path(@item)} 
            else
                render 'edit'
            end
        end
    end

    def destroy
        respond_to do |format|
            if @item.destroy
                format.html { redirect_to root_path} 
            end
        end
    end

    def complete
        respond_to do |format|
            if @item.update_attribute(:completed_at, Time.now)
                format.html { redirect_to root_path }
            end
        end
    end

    def delete_all
        if !current_user.items.blank?
            respond_to do |format|
                if current_user.items.delete_all
                    format.html { redirect_to root_path, :notice => 'All Item was successfully deleted !'}
                else
                    format.html { redirect_to root_path, :notice => 'All Item NOT successfully deleted !'}
                end
            end
        else
            respond_to do |format|
                format.html {redirect_to root_path, :alert => "There is no item in here yet!"}
            end
        end
        
    end


    private

    def item_params
        params.require(:item).permit(:title,:description)
    end

    def find_item
        @item = Item.find(params[:id])
    end
end
