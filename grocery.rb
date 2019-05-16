require 'pry' 

# Complete - Display a menu in the console for the user to interact with.
# Complete - Create a default array of hashes that represent items at a grocery store.
# Complete - a menu option to add items to a user's grocery cart.
# Conplete - a menu option to display all the items in the cart.
# Complete - a menu option to remove an item from the users cart.
# Complete - Create a menu option to show the total cost of all the items in the user's cart.
# Incomplete - Add new items to the grocery store.
# Zip it up and turn it in!



@grocery_store = [
default_hash = {item: 'default', price: '0.00', quantity: 0},
apple_hash = {item: 'apple', price: '0.05', quantity: 100},
banana_hash = {item: 'banana', price: '0.20', quantity: 166},
orange_hash = {item: 'orange', price: '0.10', quantity: 200},
watermelon_hash = {item: 'watermelon', price: '2.00', quantity: 30},
]

# I found this on stackoverflow
def deep_copy(o)
  Marshal.load(Marshal.dump(o))
end

@cart = deep_copy(@grocery_store)

for i in 1..4
  @cart[i][:quantity] = 0
end

# p @cart
# p @grocery_store

# Cloning the store to the cart is a bad idea - For a large store,
# this would copy millions of items to the cart, which is unnecessary.
# My knowledge of hashes is limited, so I'm just going to roll with it for now.

def add_item_to_cart
  puts "\n     Price     Item"
  for i in 1..4
    printf "#{i}.) $#{@grocery_store[i][:price]}     #{@grocery_store[i][:item]}\n"
  end
  puts ''
  puts "Which item would you like to purchase?"
  puts "For apples enter 1, bananas 2, etc."
  puts "Enter 0 to return to the main menu.\n"
  
  item_number = gets.to_i
  if item_number == 0
    print_menu
  elsif item_number == 1 or item_number == 2 or item_number == 3 or item_number == 4
    puts "How many #{@grocery_store[item_number][:item]}'s would you like to order?"
    item_quantity = gets.to_i
    if item_quantity <= 0
      puts "Invalid quantity - nothing has been added to cart."
    elsif item_quantity > @grocery_store[item_number][:quantity]
      puts "We're sorry, we only have #{@grocery_store[item_number][:quantity]} #{@grocery_store[item_number][:item]}'s in stock.\nYou can purchase at most #{@grocery_store[item_number][:quantity]} #{@grocery_store[item_number][:item]}'s."
    else  
      puts "Okay! #{item_quantity} #{@grocery_store[item_number][:item]}'s have been added to your cart."
      @cart[item_number][:quantity] += item_quantity
      @grocery_store[item_number][:quantity] -= item_quantity
    end
  else 
    puts "Invalid input - enter a number from 0 to 4"
  end
  add_item_to_cart
end

def remove_item_from_cart
  if 
    @cart[1][:quantity] == 0 and 
    @cart[2][:quantity] == 0 and
    @cart[3][:quantity] == 0 and
    @cart[4][:quantity] == 0
    puts "Your cart is empty"
    print_menu
  else
    puts "\nYour cart currently contains\n"
    for i in 1..4
      if @cart[i][:quantity] > 0
        printf "#{i}.) #{@cart[i][:quantity]} #{@cart[i][:item]}(s)\n"
      end
    end
  end
  puts "What item would do you want to put back?"
  puts "For apples enter 1, bananas 2, etc."
  puts "enter 0 to return to main menu"
  
  @return_item = gets.to_i
  
  if @return_item == 0
    print_menu
  elsif
    @return_item > 4
    puts "Invalid input - rerouting to return menu"
  elsif
     @cart[@return_item][:quantity] == 0
    puts "You have no #{@cart[@return_item][:item]}'s in your cart."
  elsif
    @cart[@return_item][:quantity] > 0
    puts "How many #{@cart[@return_item][:item]}'s do you want to put back?"
    return_quantity = gets.to_i
    if return_quantity <= 0
      puts "Invalid quantity - nothing has been removed from cart."
    elsif return_quantity >= @cart[@return_item][:quantity]
      puts "Your cart has been cleared of #{@cart[@return_item][:item]}'s'"
      @grocery_store[@return_item][:quantity] += @cart[@return_item][:quantity]
      @cart[@return_item][:quantity] = 0

      puts @grocery_store
      puts @cart

    else puts "Okay! #{return_quantity} #{@cart[@return_item][:item]}'s have been removed from your cart."
      @cart[@return_item][:quantity] -= return_quantity
      @grocery_store[@return_item][:quantity] += return_quantity

      puts @grocery_store
      puts @cart

    end 
  end
  remove_item_from_cart
end

def view_cart
  if @cart[1][:quantity] == 0 and 
     @cart[2][:quantity] == 0 and
     @cart[3][:quantity] == 0 and
     @cart[4][:quantity] == 0
     puts "Your cart is empty"
  else 
    puts "Your cart contains"
    for i in 1..4
      if @cart[i][:quantity] > 0
        printf "#{i}.) #{@cart[i][:quantity]} #{@cart[i][:item]}(s)"
      end
      puts ''
    end
  end
  print_menu
end
  
def cart_subtotal # Need to multiply quantity with price of each item, then sum
  @subtotal_array =[]
  for i in 0..3
    @subtotal_array[i] =("#{@cart[i+1][:quantity]}".to_f * "#{@cart[i+1][:price]}".to_f)
  end
  puts "Your subtotal is $#{sum(@subtotal_array)}"
  puts "Would you like to checkout? (y/n)"
  checkout_response = gets.strip
  if checkout_response == "y"
    checkout
  else
    print_menu
  end
end

def sum(arr)
  sum = 0.00
  arr.each do |e|
    sum += e
  end
  sum
end

def checkout
  puts "    Price   Quantity     Item"
  for i in 1..4
    puts "#{i}.) $#{@subtotal_array[i-1]}       #{@cart[i][:quantity]}         #{@cart[i][:item]} "
  end
  puts "Your total comes to $#{sum(@subtotal_array)}"
  puts "Confirm your purchase? (y/n)"
  final_checkout = gets.strip
  if final_checkout == y
    exit
  else
    print_menu
  end

end

def print_menu
  puts ''
  puts '~~~Main Menu~~~'
  puts '1. Add item to cart'
  puts '2. Remove item from cart'
  puts '3. View cart'
  puts '4. Checkout'
  puts '5. Add item to grocery store'
  puts 'Input a number and press enter to proceed'
  puts ''

  main_input = gets.to_i
  if main_input == 1
    add_item_to_cart
  elsif
    main_input == 2
  remove_item_from_cart

  elsif
    main_input == 3
  view_cart

  elsif
    main_input == 4
  cart_subtotal

  elsif
    main_input == 5
    #add item to store method
    #probably won't be able to implement this
    puts "Coming soon!"
    print_menu
  end
end

print_menu
