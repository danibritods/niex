class SalesController < ApplicationController
    def new
        # sale = Sale.new
        @sale_products = []
        Sale.build_inventory
        if session[:user_id]
            @user = User.find(session[:user_id])
            if params[:search_text]
                @product = params["search_text"]
                Sale.new_product(@product)
                @sale_products = Sale.show_products
            end
        end   
    end
    def search 
        @product = params#[:query] + "t"#Product.find(params[:query])
    end
    def clean
        Sale.clean_products
    end

end

class Sale
    @@products = []
    @@products_count = 0
    @@inventory = {}

   def self.new_product(prod)
    @@products_count += 1
    @@products.append(
        {prod_count: @@products_count}.merge(get_product(prod))
    )
   end

   def self.show_products
    @@products
   end

   def self.clean_products
    @@products = []
    @@products_count = 0
   end

   def self.get_product(prod_code) 
     @@inventory[prod_code] || {prod_count: @@products_count,
                                prod_code: prod_code,
                                prod_name: "abc_" + prod_code,
                                prod_price: 9.99}
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