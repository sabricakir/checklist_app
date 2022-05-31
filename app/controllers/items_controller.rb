class ItemsController < ApplicationController
    before_action :find_item, only: [:show, :edit, :update, :destroy]
    def index
        @items = Item.all
    end

    def show
        
    end

    def new
        @item = Item.new
    end

    def create
        @item = Item.create(item_params)
        respond_to do |format|
            if @item.save
                format.html { redirect_to root_path, :notice => 'Item was successfully created !' } 
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
                format.html { redirect_to item_path(@item), :notice => 'Item was successfully updated !' } 
            else
                render 'edit'
            end
        end
    end

    def destroy
        respond_to do |format|
            if @item.destroy
                format.html { redirect_to root_path, :notice => 'Item was successfully deleted !' } 
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
