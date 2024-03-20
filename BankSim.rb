#Bank Account Sim
#superclass
class Account

    	def initialize
        @@name = "Calvin Brooks"   #my name
        @@balance = 500            #arbitray account balance
        @@savings_balance = 2500   #arbitrary account balance
        @account_num = 7789456432  #arbitrary account number 
        @@history = Array.new
    	end   

      	public
    	
    	#array of strings for authorized users
    	authUsers = ['John Smith', 'Chris Sims', 'Alan Brooks', 'Lebron James']
    	
  		def passcode
  		@passcode = 1234 #arbitray passcode
  		end 
  		
      	def welcome
        	puts "\nWelcome #@@name!\nTo access your account, please enter your passcode\n(hint: its 1234)"
        	@input_passcode = gets.chomp.to_i
      	end      

		#helper method
     	def pin_error 
        	return "\nAccess denied: incorrect passcode"
     	end
 
 		#used as I/O with user
      	def display
        	if welcome == passcode
        	action = "x"
        		while action != "e"
          		puts "\nInput S: to show balance\nInput D: to deposit money\nInput W: to withdraw money\nInput T: to transfer money\nInput R: to show recent transactions\nInput E: to exit\n"
          		action = gets.chomp.downcase
            	case action
            	when "d"
            	deposit
            	when "s"
            	show_balance
            	when "w"
           		withdraw
           		when "t"
           		transfer
           		when "r"
           		show_recent_transactions
           		when "e"
           		break
            	else
        		puts "\nPlease enter provided options"
        		end
          	end
        	else puts pin_error
        	end    
      	end
      	
      	
      	def show_recent_transactions
        	puts @@history				#printing an array of strings listing transactions 
      	end
      	
      	def amount
        	puts "\nInput desired amount"   #helper method
        	@money = gets.to_i
      	end

      	def over_error
        	puts "\nInsufficient Funds.\nYour balance: $#@@balance\n"    #helper method
      	end
      	
      	#below methods will be overwritten in subclass
      	def show_balance
        	puts "\nBalance: $#@@balance\n"   
      	end
      	
      	#each method below updates balances as needed and adds a new string to our history
      	def deposit
       		@@balance += amount
        	puts "\nDeposited: $#@money.\nNew balance is $#@@balance.\n"
        	str = "\nDeposited $#@money into checking account"
        	@@history.push str
      	end

      	def withdraw
        	if  amount <= @@balance
          	@@balance -= @money
        	str = "\nWithdrew $#@money from checking account"
        	@@history.push str
           	puts "\nWithdrew: $#@money. Updated balance: $#@@balance.\n"  
        	else
            puts over_error
        	end
      	end
      	
      	def transfer 
      		if  amount <= @@balance
          	@@balance -= @money
          	@@savings_balance += @money #moving money to savings balance
        	str = "\nTransferred $#@money from checking account into savings account"
        	@@history.push str
           	puts "\nTransferred $#@money to savings account\nUpdated savings account balance: $#@@savings_balance.\nUpdated checking account balance: $#@@balance\n"  
        	else
            puts over_error
        	end
      	end
end  

class Savings_Account < Account
 
    	# constructor of deriver class
		def initialize
        @account_num = 7789456433  #different account number 
        @interest_rate = 5         #arbitray interest rate represented as percent (5%)
        @withdraw_count = 0
        @transfer_count = 0
    	end

      	def show_balance
        	puts "\nBalance: $#@@savings_balance\n"   
      	end
      	
      	def deposit
       		@@savings_balance += amount
        	puts "\nDeposited: $#@money.\nNew balance is $#@@savings_balance.\n"
        	str = "\nDeposited $#@money into savings account"
        	@@history.push str
      	end

		#withdraws and transfers cannot exceed more than 3
      	def withdraw
      		@withdraw_count += 1
      		if @withdraw_count != 4
        		if  amount <= @@savings_balance
          		@@savings_balance -= @money
        		str = "\nWithdrew $#@money from savings account"
        		@@history.push str
           		puts "\nWithdrew: $#@money. Updated balance: $#@@savings_balance.\n"  
        		else
            	puts over_error
            	end
            else
            puts "\nYou have reached your maximum number of withdrawals (3)\n"
            end	
      	end
      	
      	def transfer 
      		@transfer_count += 1
      		if @transfer_count != 4
      			if  amount <= @@savings_balance
          		@@savings_balance -= @money
          		@@balance += @money #moving money to checking balance
        		str = "\nTransferred $#@money from savings account into checking account"
        		@@history.push str
           		puts "\nTransferred $#@money to checking account\nUpdated checking account balance: $#@@balance.\nUpdated savings account balance: $#@@savings_balance\n"  
        		else
            	puts over_error
        		end
        	else
        	puts "\nYou have reached your maximum number of transfers (3)\n"
        	end
      	end

    
end

    checking_account = Account.new
    savings_account = Savings_Account.new
    
    #ask if they would like to access savings account or checking
    p
    puts "Welcome to Lit Banks, LLC. \nInput S: to access savings account\nInput C: to access checkings account\n"
    choice = gets.chomp.downcase
    case choice
        when "c"
        checking_account.display
        when "s"
        savings_account.display
        else
        puts "\nPlease enter provided options"
    end