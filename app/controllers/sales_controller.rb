class SalesController < ApplicationController
    def index
        # @search = " "#params[:barcode_query]
        # @sale_products = []
        # if params[:barcode_query]
        #     Sale.new_product(@product)
        #     @sale_products = Sale.show_products
        # end
    end

    def create
        #Sale.save
        Sale.destroy
        redirect_to sale_url
    end

    def new
        if session[:user_id]
            @user = User.find(session[:user_id])
            if not @total
                Sale.build_inventory
            end
            @sale_products = Sale.show_products
            @total = Sale.show_total

        end
    end

    def search 
        # @product = params["/sell"]["query"]
        query = params["/sell"]["query"]
        quantity, prod_code = treat_query(query)
        Sale.new_product(quantity, prod_code)
        redirect_to sale_url
    end
    def destroy
        Sale.destroy
        redirect_to sale_url
    end
    
    private 
     def treat_query(query)
         split_query = query.split("*")
             if split_query.count == 2
                     quantity, prod_code = split_query
                     return [quantity, prod_code]
                 else
                     return ["1", split_query[0]]
             end
    end
end

class Sale

    @@products = []
    @@products_count = 0
    @@inventory = {}
    @@sale_total = 0


   def self.new_product(quantity, prod_code)
        @@products_count += 1 
        prod_info = get_product(prod_code)
        prod_total = prod_info[:prod_price].to_f * quantity.to_f
        @@sale_total += prod_total
    
        @@products.append(
            {prod_count: @@products_count, prod_quantity: quantity, prod_total: prod_total }.merge(prod_info)
        )
   end

   def self.show_products
    @@products
   end

   def self.show_total
    @@sale_total
   end

   def self.destroy
    @@products = []
    @@products_count = 0
    @@sale_total = 0
   end

    def self.get_product_test(prod_code) 
     @@inventory[prod_code] || {prod_code: prod_code,
                                prod_name: "abc_" + prod_code,
                                prod_price: 9.99}
    end
    def self.get_product(prod_code) 
        prod = Product.find_by(barcode: prod_code)
        if prod
            {prod_code: prod.barcode, prod_name: prod.description, prod_price: prod.price}
        else
            {prod_code: prod_code,
            prod_name: "abc_" + prod_code,
            prod_price: 9.99}
        end
    end



   def self.build_inventory()
    prod_list = [
                    ["3", "Pão Francês Kg", 19.9],
                    ["4", "Pão Doce Kg", 26.00],
                    ["104", "Mussarea Kg", 54.86]
                ]

    @@inventory = prod_list.map{|prod_code, prod_name, prod_price| [prod_code, {prod_code: prod_code, prod_name: prod_name, prod_price: prod_price}]}.to_h
   end
   
end