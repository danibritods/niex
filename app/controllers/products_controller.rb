class ProductsController < ApplicationController
    def index 
        @products = Product.all
         if session[:user_id]
            @user = User.find(session[:user_id])
         end
    end
    def show
        @product =  Product.find(params[:id])
    end
    def new
         @product = Product.new
    end

    def create
        @product = Product.new(product_params)

            if @product.save
            redirect_to @product
            else
            render :new, status: :unprocessable_entity
            end
    end

    def edit
        @product = Product.find(params[:id])
    end

    def update
        @product = Product.find(params[:id])

        if @product.update(product_params)
        redirect_to @product
        else
        render :edit, status: :unprocessable_entity
        end
    end

    def destroy
        @product = Product.find(params[:id])
        @product.destroy

        redirect_to products_path, status: :see_other
    end
    
    private
        def product_params
        params.require(:product).permit(:description, :barcode, :price)
        end
end