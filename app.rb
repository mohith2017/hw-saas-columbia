require 'sinatra/base'
require 'sinatra/flash'
require './lib/hangperson_game.rb'

class HangpersonApp < Sinatra::Base

  enable :sessions
  register Sinatra::Flash
  
  before do
    @game = session[:game] || HangpersonGame.new('')
  end
  
  after do
    session[:game] = @game
  end
  
  # These two routes are good examples of Sinatra syntax
  # to help you with the rest of the assignment
  get '/' do
    redirect '/new'
  end
  
  get '/new' do
    erb :new
  end
  
  post '/create' do
    # NOTE: don't change next line - it's needed by autograder!
    word = params[:word] || HangpersonGame.get_random_word
    # NOTE: don't change previous line - it's needed by autograder!

    @game = HangpersonGame.new(word)
    session[:state] = nil
    
#     erb :show
    redirect '/show'
  end
  
  # Use existing methods in HangpersonGame to process a guess.
  # If a guess is repeated, set flash[:message] to "You have already used that letter."
  # If a guess is invalid, set flash[:message] to "Invalid guess."
  post '/guess' do
    letter = params[:guess].to_s[0]
    ### YOUR CODE HERE ###
    
#     @ = HangpersonGame.guess(letter)
      
    final = nil
    
    begin
    final = @game.guess(letter)
    rescue ArgumentError => e
        flash[:message] = "Invalid guess."
    end
      
    if not final.nil? and not final
        flash[:message] = "You have already used that letter."
    end
      
#     if @game.guess(letter).@wrong_guesses
#         flash[:message] = "You have already used that letter."
#     end

    
    
   
#     flash[:message] = "You have already used that letter."
    redirect '/show'
  end
  
  # Everytime a guess is made, we should eventually end up at this route.
  # Use existing methods in HangpersonGame to check if player has
  # won, lost, or neither, and take the appropriate action.
  # Notice that the show.erb template expects to use the instance variables
  # wrong_guesses and word_with_guesses from @game.
  get '/show' do
    ### YOUR CODE HERE ###
    #guesses = @wrong_guesses 
#     if @game.check_win_or_lose == :win 
#         session[:state] = :win
# 		redirect "/win";
# 	end
	
# 	if @game.check_win_or_lose == :lose
#         session[:state] = :lose
# 		redirect "/lose";
# 	end
      
#     status = @game.check_win_or_lose
#     if status == :win
# 		redirect "/win";
# 	end
	
# 	if status == :lose
# 		redirect "/lose";
# 	end
	
# 	@wrong_guesses = @game.wrong_guesses
# 	@word_with_guesses = @game.word_with_guesses
    
    erb :show # You may change/remove this line
  end
  
  get '/win' do
    ### YOUR CODE HERE ###
#     if @game.check_win_or_lose != :win
# 		redirect '/show'
# 	end
    erb :win # You may change/remove this line
  end
  
  get '/lose' do
    ### YOUR CODE HERE ###
#     if @game.check_win_or_lose != :lose
# 		redirect '/show'
# 	end
    erb :lose # You may change/remove this line
  end
  
end