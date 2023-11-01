class SaleDiscount
  def initialize
    @price_table = {
      milk:  {
        unit_price: 3.97,
        sale_price: {
          unit: 2,
          price: 5
        }
      },
      bread:  {
        unit_price: 2.17,
        sale_price: {
          unit: 3,
          price: 6
        }
      },
      banana:  {
        unit_price: 0.99
      },
      apple:  {
        unit_price: 0.89
      },
      bread: {
        unit_price: 2.17,
        sale_price: {
          unit: 3,
          price: 6
        }
      }
    }
    @final_user_order = {}
    @discount = 0
  end
  
  def print_user_table(order_hash)  
    order_hash.each do |k,v|
      if @price_table.has_key? k
        @final_user_order[k] = {}
        if @price_table[k].has_key? :sale_price
          sale_unit = @price_table[k][:sale_price][:unit]
          sale_price = @price_table[k][:sale_price][:price]
          if v >=  sale_unit
            add_sale_price(k, v, sale_unit, sale_price)      
          end
        else
          add_unit_sale_price(k, v)
        end
      end  
    end
    print_me
  end
  
  def  add_unit_sale_price(k, v)
    original_unit_price = @price_table[k][:unit_price]
    @final_user_order[k][v] = v * original_unit_price
  end
  
  def add_sale_price(k, v, sale_unit, sale_price)
    original_unit_price = @price_table[k][:unit_price]
    actual_unit = v / sale_unit
    if v % sale_unit == 0
      @final_user_order[k][v] = actual_unit * sale_price
    else
      @final_user_order[k][v] = actual_unit * sale_price
      @final_user_order[k][v] = @final_user_order[k][v] + ((v % sale_unit ) * original_unit_price)   
    end
    @discount += ( (v * original_unit_price) - @final_user_order[k][v])
  end
  
  def print_me()
    allv = @final_user_order.values
    sum = 0
    allv.each  { |k,v| sum += k.values.sum }
    p "Your total order is #{sum}"
    p "your total discount is #{@discount}"
    p "your final order is #{@final_user_order}"
  end

  def get_user_list
   p "Please Enter comma seperated values"
   @user_list = "milk,milk,milk,bread,bread,banana,bread,apple,bread"#gets.chomp
   calculate_price
  end
  
  def calculate_price
    user_order_hash = make_a_user_order_hash(@user_list)
    print_user_table(user_order_hash)
  end
  
  def make_a_user_order_hash(user_list)
    user_list.split(',').group_by{ |w| w }.map{ |k, v| [k.to_sym, v.count] }.to_h
  end
end


sale_discount = SaleDiscount.new
sale_discount.get_user_list
